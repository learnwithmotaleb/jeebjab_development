// Driver task state machine (see Driver Task Status API):
//   pending → active → picked_up → in_transit → completed
// A task can also skip straight from active/picked_up to completed, and
// can be cancelled from any non-terminal state.
enum TaskStatus { pending, active, pickedUp, inTransit, completed, cancelled }

TaskStatus? taskStatusFromString(String? status) {
  switch (status) {
    case 'pending':
      return TaskStatus.pending;
    case 'active':
      return TaskStatus.active;
    case 'picked_up':
      return TaskStatus.pickedUp;
    case 'in_transit':
      return TaskStatus.inTransit;
    case 'completed':
      return TaskStatus.completed;
    case 'cancelled':
      return TaskStatus.cancelled;
    default:
      return null;
  }
}

String? taskStatusToString(TaskStatus? status) {
  switch (status) {
    case TaskStatus.pending:
      return 'pending';
    case TaskStatus.active:
      return 'active';
    case TaskStatus.pickedUp:
      return 'picked_up';
    case TaskStatus.inTransit:
      return 'in_transit';
    case TaskStatus.completed:
      return 'completed';
    case TaskStatus.cancelled:
      return 'cancelled';
    case null:
      return null;
  }
}
