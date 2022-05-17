class CustomResponseModel<T> {
  Status status;
  T data;
  String message;

  CustomResponseModel.loading(this.message) : status = Status.LOADING;
  CustomResponseModel.completed(this.data) : status = Status.COMPLETED;
  CustomResponseModel.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
