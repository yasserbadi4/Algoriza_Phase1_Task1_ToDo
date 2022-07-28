abstract class ToDoStates {}

class ToDoInitialState extends ToDoStates{}

class ToDoCreateDatabaseState extends ToDoStates{}

class ToDoInsertToDatabaseState extends ToDoStates{}

class ToDoSuccessGetDataFromDatabaseState extends ToDoStates{}

class ToDoSuccessGetAllDataFromDatabaseState extends ToDoStates{}


class ToDoLoadingGetDataFromDatabaseState extends ToDoStates{}

class ToDoGetDatabaseState extends ToDoStates{}

class ToDoSuccessUpdateDatabaseState extends ToDoStates{}


class ToDoSuccessDeleteDataFromDatabaseState extends ToDoStates{}

class ToDoChangesReminderState extends ToDoStates{}
class ToDoChangesRepeatState extends ToDoStates{}