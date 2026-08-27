# Changelog — 2026-08-27 push

Commit: `418c1f2` — "Add route-map view (pickup/dropoff/live-location) and fix analyzer issues"
Pushed to: `origin/main` (`d3ac4bd..418c1f2`)
105 files changed, +2182 / -1018 lines

This groups the same 105 files by what actually changed in each, so it's
clear which edits are real logic changes vs. mechanical/cosmetic ones.

---

## 1. New feature: route map (pickup / drop-off / live location)

**New files:**
- `lib/presentation/screen/show_map/controller/route_map_controller.dart`
- `lib/presentation/screen/show_map/screen/route_map_screen.dart`
- `lib/presentation/screen/show_map/widget/route_info_card.dart`
- `lib/service/google_map_services.dart` (existed but was broken — see §3)

Shows a job's pickup and drop-off as two markers with the real driving
polyline and distance/duration between them (Google Directions API),
falling back to a straight line + haversine distance if Directions fails.
Recycling-type posts only have a pickup (no drop-off) — those get a
single-marker view instead of an error. Also shows the device's current
GPS position (reusing `GoogleMapServices`, no duplicate location polling)
as a third marker with its own route to the pickup point.

**Wired into** (previously called `Get.toNamed(RoutePath.showMap)` with no
arguments at all — opened a blank address-picker screen):
- `lib/presentation/screen/post_details/controller/post_details_controller.dart`
- `lib/presentation/screen/driver_section/driver_bottom_nav/page/task_details/controller/task_details_controller.dart`
- `lib/presentation/screen/status_details/controller/status_details_controller.dart`

All three now also parse `pickup`/`dropoff` **coordinates** from the API
response (previously only the address text was read).

**Route registration:**
- `lib/core/routes/route_path.dart` — added `routeMap` path.
- `lib/core/routes/routes.dart` — added the `GetPage` entry.

---

## 2. Notification read/unread + unread count

- `lib/service/api_url.dart` — added `unreadNotificationCount`,
  `markNotificationAsRead`, `markAllNotificationsAsRead` (documented
  backend endpoints that had no client mapping at all).
- `lib/presentation/screen/notification/controller/notification_controller.dart`
  — `markAsRead()` was local-only (SharedPreferences), never synced to
  the backend; now calls `PATCH /notification/:id/read`. Added
  `markAllAsRead()` (`PATCH /notification/read-all`) and
  `fetchUnreadCount()` (`GET /notification/count`), kept in sync via the
  list endpoint's own `meta.unreadCount` plus decrements on delete.
  Also added `openRelatedItem()` — see below.
- `lib/presentation/screen/notification/screen/notification_screen.dart`
  — added a "mark all as read" app bar button; tap now calls
  `controller.openRelatedItem(item)` instead of blindly opening Status
  Details with no arguments.
- `lib/presentation/screen/notification/widget/notification_card_widget.dart`
  — cosmetic only (`.withOpacity` fix, see §5).

**Notification → Status Details linking (best-effort, backend-limited):**
Backend notification objects carry no `postId`/status link at all
(confirmed live against the real API). "New Job Request" notifications
are the one exception — they embed the job's title in quotes in the
message text. `openRelatedItem()` extracts that title and matches it
against the user's own posts to resolve a real id, then opens Status
Details with it. This is a documented stopgap (duplicate titles pick the
first match) pending a real linking field from the backend.

---

## 3. `google_map_services.dart` — fixed and cleaned up

Was broken: imported `package:westchester/...` (a different project's
package name) instead of `package:jeebjab/...`, so the app couldn't even
compile while this file was wired into `main.dart`. Fixed the imports,
then cleaned up dead code left over from that: an unused `ApiClient`
field, unused imports, and a commented-out REST call to a
`liveLocationUpdate` endpoint that doesn't exist. Replaced that comment
with the real mechanism (the documented `updateLocation` **socket**
event), left commented since this service isn't wired into any
"start tracking this task" trigger yet.

- `lib/main.dart` — no functional change here; confirmed it already
  requests location permission on launch and registers
  `GoogleMapServices` as permanent before `runApp`.

---

## 4. My Post / Status Details data-correctness fixes

- `lib/presentation/screen/bottom_nav/page/my_post/controller/my_post_controller.dart`
  — `buildDetailArguments()` was passing status strings that didn't match
  the real API values (`in_transit`/`delivered` instead of
  `active`/`completed`). Harmless in practice (Status Details re-fetches
  and overwrites from the real response before render), but wrong and
  confusing — now passes the real status value directly.
- `lib/presentation/screen/status_details/controller/status_details_controller.dart`
  — was fabricating a fake tracking number from a substring of the Mongo
  `_id`; the API actually returns a real `jobId` field for exactly this
  purpose. Now uses `jobId` when present, falling back to the old
  substring only for older posts created before that field existed.
- `lib/presentation/screen/bottom_nav/page/my_post/screen/my_post_screen.dart`,
  `.../my_post/widget/my_post_card.dart` — cosmetic only (§5).
- `lib/presentation/screen/status_details/screen/status_details_screen.dart`,
  `.../status_details/widget/status_details_card.dart` — cosmetic only (§5),
  plus the route-map wiring already covered in §1.
- `lib/presentation/screen/post_details/screen/post_details_screen.dart`,
  `.../post_details/widget/image_carousel_widget.dart`,
  `.../post_details/widget/location_card_widget.dart` — cosmetic only (§5).
- `lib/presentation/screen/driver_section/.../task_details/screen/task_details_screen.dart`
  — cosmetic only (§5).

---

## 5. Translation map duplicate-key fixes

- `lib/global/language/eng/eng.dart`, `lib/global/language/arabic/arabic.dart`
  — fixed all 23 `equal_keys_in_map` analyzer warnings. Most were
  harmless (two `AppStrings` constants sharing the exact same underlying
  phrase, so the same translation-map key twice) — the redundant entry
  was removed. **One was a real bug:** `eng.dart` had
  `AppStrings.rating: "Open Map"` (a copy-paste key typo), which meant
  `AppStrings.rating.tr` silently rendered *"Open Map"* instead of
  *"Rating"* anywhere that string was shown in English. Fixed to
  `AppStrings.openMap: "Open Map"`. A couple of Arabic entries had
  genuinely different wording under the same duplicated key; kept
  whichever currently wins (the last-declared one) so on-screen text
  doesn't change, and just removed the shadowed, already-dead line.

---

## 6. Cosmetic: `.withOpacity()` → `.withValues(alpha:)`

`Color.withOpacity()` is deprecated in the current Flutter SDK. Bulk-
replaced all 172 call sites across 90 files with the non-deprecated
`.withValues(alpha:)` form (regex-based, verified beforehand that no
call site had a nested-parentheses argument that would break a simple
substitution). This is the source of most of the remaining files in this
push not already mentioned above — every one of them is a same-meaning,
single-argument-name change with no behavior difference:

```
lib/core/theme/dark_theme.dart
lib/core/theme/light_theme.dart
lib/presentation/screen/add_card/widget/card_number_field.dart
lib/presentation/screen/add_card/widget/expiry_cvv_row.dart
lib/presentation/screen/auth/account_active_verification/screen/account_active_verification_screen.dart
lib/presentation/screen/auth/choose_vehicle_type/screen/choose_vehicle_type_screen.dart
lib/presentation/screen/auth/company_driver_auth/driver_verification/screen/driver_verification_screen.dart
lib/presentation/screen/auth/company_driver_auth/select_company/screen/select_company_screen.dart
lib/presentation/screen/auth/company_driver_auth/signup_driver/screen/driver_signup_screen.dart
lib/presentation/screen/auth/customer_verification/screen/customer_verification_screen.dart
lib/presentation/screen/auth/forget/screen/forget_screen.dart
lib/presentation/screen/auth/license_number/screen/license_number_screen.dart
lib/presentation/screen/auth/login/screen/login_screen.dart
lib/presentation/screen/auth/reset_password/screen/reset_password_screen.dart
lib/presentation/screen/auth/upload_document/screen/upload_document_screen.dart
lib/presentation/screen/auth/vehicle_information/screen/vehicle_information_screen.dart
lib/presentation/screen/capture_image/screen/capture_image_screen.dart
lib/presentation/screen/capture_image/widget/capture_image_preview.dart
lib/presentation/screen/capture_info/widget/restricted_items_widget.dart
lib/presentation/screen/capture_info/widget/size_card_widget.dart
lib/presentation/screen/chat/screen/chat_screen.dart
lib/presentation/screen/chat/widget/chat_input_widget.dart
lib/presentation/screen/chat/widget/chat_message_buble_widget.dart
lib/presentation/screen/create_post/screen/create_post_screen.dart
lib/presentation/screen/create_post/widget/catagory_card_widget.dart
lib/presentation/screen/driver_section/driver_bottom_nav/page/driver_home/widget/current_task_card.dart
lib/presentation/screen/driver_section/driver_bottom_nav/page/driver_home/widget/driver_header_widget.dart
lib/presentation/screen/driver_section/driver_bottom_nav/page/driver_home/widget/recent_job_card.dart
lib/presentation/screen/driver_section/driver_bottom_nav/page/task/screen/task_screen.dart
lib/presentation/screen/driver_section/driver_bottom_nav/page/task/widget/task_card_widget.dart
lib/presentation/screen/drop_off_floor/screen/drop_off_floor_screen.dart
lib/presentation/screen/i_will_pay/screen/i_will_pay_screen.dart
lib/presentation/screen/job/be_come_a_driver/screen/be_come_driver_screen.dart
lib/presentation/screen/job/be_come_a_driver/widget/driver_type_card.dart
lib/presentation/screen/job/customer_job_post/screen/customer_job_post_screen.dart
lib/presentation/screen/job/customer_job_post/widget/be_come_driver_banner_card.dart
lib/presentation/screen/job/delivery/widget/delivery_image_card.dart
lib/presentation/screen/job/delivery/widget/delivery_table_widget.dart
lib/presentation/screen/job/job_post/widget/job_post_drawer_widget.dart
lib/presentation/screen/job/job_post/widget/sort_dropdown_widget.dart
lib/presentation/screen/not_allow/screen/not_allow_screen.dart
lib/presentation/screen/notification/widget/notification_card_widget.dart
lib/presentation/screen/overview/widget/overview_publish_section.dart
lib/presentation/screen/pickup_address/screen/pickup_address_screen.dart
lib/presentation/screen/pickup_date_time/screen/pickup_datetime_screen.dart
lib/presentation/screen/pickup_date_time/widget/pickup_option_card_widget.dart
lib/presentation/screen/pickup_floor/screen/pickup_floor_screen.dart
lib/presentation/screen/pickup_floor/widget/inline_label_field_widget.dart
lib/presentation/screen/pickup_floor/widget/toggle_option_row_widget.dart
lib/presentation/screen/placement_pickup/widget/placement_option_row_widget.dart
lib/presentation/screen/profile/account_settings/account/screen/account_screen.dart
lib/presentation/screen/profile/account_settings/bank_card/screen/bank_card_screen.dart
lib/presentation/screen/profile/account_settings/bank_card/widget/bank_card_item_widget.dart
lib/presentation/screen/profile/account_settings/change_password/screen/change_password_screen.dart
lib/presentation/screen/profile/account_settings/driver_profile/screen/driver_profile_screen.dart
lib/presentation/screen/profile/account_settings/edit_driver_profile/widget/document_upload_section_widget.dart
lib/presentation/screen/profile/account_settings/edit_driver_profile/widget/editable_info_section_widget.dart
lib/presentation/screen/profile/account_settings/edit_profile/screen/edit_profile_screen.dart
lib/presentation/screen/profile/contact_&_support/screen/contact_and_support_screen.dart
lib/presentation/screen/profile/faqs/screen/faqs_screen.dart
lib/presentation/screen/profile/language/screen/language_screen.dart
lib/presentation/screen/profile/privacy_&_policy/screen/privacy_and_policy_screen.dart
lib/presentation/screen/profile/profile/screen/profile_screen.dart
lib/presentation/screen/profile/terms_&_condition/screen/terms_and_condition_screen.dart
lib/presentation/screen/read_more/screen/read_more_post_screen.dart
lib/presentation/screen/review_list/widget/review_list_item_card.dart
lib/presentation/screen/review_profile/widget/review_card_widget.dart
lib/presentation/screen/set_drop_off_address/screen/set_drop_of_address_screen.dart
lib/presentation/screen/show_map/screen/show_map_screen.dart
lib/presentation/screen/show_map/widget/location_bottom_card.dart
lib/presentation/screen/show_map/widget/location_search_bar.dart
lib/presentation/screen/west_type/screen/west_type_screen.dart
lib/presentation/screen/west_type/widget/west_item_title_widget.dart
lib/utils/app_text_style/app_text_style.dart
lib/widget/app_icon_badge.dart
lib/widget/confirmataion_alert.dart
```

Two files got a slightly bigger, deliberate rewrite alongside their
`withOpacity` fix (real logic changes, not just the deprecation fix):
- `lib/presentation/screen/profile/profile/widget/profile_header_widget.dart`
  — avatar now falls back to a plain icon instead of a hardcoded stock
  photo when the account has no avatar; rating now uses
  `toStringAsFixed(2)` instead of raw `.toString()` (was rendering
  `4.6666666666666666`).
- `lib/presentation/screen/review_profile/widget/profile_header_widget.dart`,
  `.../review_profile/widget/rating_breakdown_widget.dart` — same
  `withOpacity` fix only; no logic change.

---

## 7. Whitespace / line-ending noise (no real change)

The bulk `find | xargs sed -i` command used for §6 rewrites **every**
file it touches to LF line endings, even ones where the regex found no
match. A few files in this repo were stored with CRLF, so they show up
in the diff with large line counts despite having **zero** semantic
change. Verified with `git diff -w` (ignore-whitespace) against the
previous commit — these come back completely empty:

- `lib/presentation/screen/auth/forget/controller/forget_controller.dart`
- `lib/presentation/screen/auth/reset_password/controller/reset_password_controller.dart`

If you'd rather these stay byte-for-byte untouched in future pushes, the
fix is a `.gitattributes` with `*.dart text eol=lf` (or `=crlf`, whichever
this project standardizes on) so git stops flip-flopping on them.
