abstract class TasksStates {}

class TasksnitialState extends TasksStates {}

class TasksDatabaseInitialized extends TasksStates {}

class TasksDatabaseTableCreated extends TasksStates {}

class TasksDatabaseOpened extends TasksStates {}

class TasksDatabaseCreated extends TasksStates {}

class TasksDatabaseLoading extends TasksStates {}

class RemoveTaskSuccess extends TasksStates {}

class RemoveTaskError extends TasksStates {}

class TasksDatabase extends TasksStates {}

class TasksSelect extends TasksStates {}
class UpdatedTask extends TasksStates {}