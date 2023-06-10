class StatusMessage {
  bool status;
  String message;

  StatusMessage({
    this.status = false,
    this.message = "",
  });

  factory StatusMessage.initial() {
    return StatusMessage(
      status: false,
      message: "",
    );
  }
}
