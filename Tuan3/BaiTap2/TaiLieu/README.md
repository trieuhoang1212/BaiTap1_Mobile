## **1. Kế thừa (Inheritance)**

Đây là nguyên lý rõ nhất. Bạn tạo ra các class mới bằng cách kế thừa từ các class có sẵn của Flutter để tái sử dụng các tính năng của chúng.

Trong code:

`class MyApp extends StatelessWidget`: MyApp kế thừa toàn bộ tính chất của một Widget không có trạng thái.

`class PaymentPage extends StatefulWidget`: PaymentPage kế thừa tính chất của một Widget có trạng thái.

`class \_PaymentPageState extends State<PaymentPage>`: Kế thừa logic quản lý trạng thái (State) từ Flutter.

## **2. Đa hình (Polymorphism)**

Nguyên lý này thể hiện qua việc ghi đè (override) các phương thức của lớp cha để thực hiện hành vi riêng của lớp con.
Trong code:
Từ khóa `@override`:

```Dart
@override
Widget build(BuildContext context) { ... }
```

Bạn đang ghi đè phương thức build của lớp cha (StatelessWidget hoặc State). Flutter gọi hàm build này, nhưng nó sẽ chạy phiên bản build mà bạn viết (đa hình runtime).
`createState()`: Bạn ghi đè hàm này để trả về instance của \_PaymentPageState do bạn định nghĩa thay vì State mặc định.

## **3. Đóng gói (Encapsulation)**

- Nguyên lý này giúp che giấu dữ liệu và trạng thái nội bộ, chỉ cho phép truy cập qua các phương thức được quy định.
  Trong code:
  -Dấu gạch dưới \_: `Class \_PaymentPageState` bắt đầu bằng dấu gạch dưới. Trong Dart, điều này có nghĩa là class này là private (riêng tư) đối với file này. Các file khác không thể truy cập trực tiếp vào State này.

Biến `selectedPaymentMethod` được khai báo bên trong `class \_PaymentPageState` và chỉ được thay đổi thông qua hàm setState bên trong class đó.

Logic xử lý logo `(getSelectedLogo)` được gói gọn bên trong class, bên ngoài không cần biết logic lấy ảnh như thế nào.

## **4. Trừu tượng hóa (Abstraction)**

Code của bạn làm việc với các khái niệm trừu tượng thay vì chi tiết cụ thể ở mức thấp.

Trong code:

Hàm build trả về một Widget. Widget là một lớp trừu tượng. Bạn không cần biết Scaffold hay ElevatedButton vẽ từng điểm ảnh (pixel) lên màn hình như thế nào. Bạn chỉ cần biết giao diện (interface) và các tham số của chúng để sử dụng.

Bạn tách logic hiển thị từng dòng thanh toán ra thành một hàm riêng buildPaymentMethod. Hàm này trừu tượng hóa việc tạo ra một ô thanh toán phức tạp; phần build chính chỉ cần gọi tên hàm là xong.

## **5. Kết hợp (Composition)**

### Trong code:

Thay vì tạo ra một class ButtonWithTextAndImage, bạn kết hợp các Widget nhỏ lại với nhau:
`Container` chứa `RadioListTile`.

`RadioListTile` chứa `Row`.

`Row` chứa `Text` và `Image`.
