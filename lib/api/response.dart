/* 

© جميع الحقوق محفوظة لموقع المصدر لتقنية المعلومات 2021.

*/
class ResponseApi<T> {
  int success;
  String message;
  T model;

  ResponseApi({this.message, this.success, this.model});
}
