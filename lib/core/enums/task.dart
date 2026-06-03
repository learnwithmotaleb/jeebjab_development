enum TaskStatus { active, completed, cancelled }

TaskStatus? taskStatusFromString(String? status) {
  switch (status) {
    case 'active':
      return TaskStatus.active;
    case 'completed':
      return TaskStatus.completed;
    case 'cancelled':
      return TaskStatus.cancelled;
    default:
      return null;
  }
}

String? taskStatusToString(TaskStatus? status) => status?.name;