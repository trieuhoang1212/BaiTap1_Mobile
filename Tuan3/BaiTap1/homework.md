## **1. NULLABLE LÀ GÌ ?**

- Nullable là khi sử dụng giá trị này thì nó có 2 trạng thái là trả về 1 giá trị hoặc là trả về null,
- **Ví dụ:** đơn giản là int thì trả về giá trị là 0, bool trả về là false nhưng nếu mình không muốn nó trả về giá trị vậy thì sao thì đó là vì sao mình áp dụng cái nullable vào là vậy.

### _một đoạn code của C#:_

```cs
// thêm giá trị nullable ở đây
int? tuoi = null;

if(tuoi.hasValue){
    console.WriteLine($"Tuoi cua ban la: {tuoi.Value}");
}
else{
    console.WriteLine("Chua co du lieu tuoi cua ban");
}

int tuoi_that = tuoi ?? 18;
```

**→ đoạn cho thấy giá trị 'tuoi' không trả về 0 mà sẽ là hiển thị không có dữ liệu trong đó.**

## 2. KHI NÀO NÊN DÙNG\KHÔNG NÊN DÙNG?

- Vậy mình nên dùng vào hoàn cảnh thực tế nào trong đoạn code của mình thì theo mình nghĩ là khi giá trị đó bạn muốn nó ngầm định nó trả về một gì đó mặc định chứ phải 0, và cảm thấy các giá trị 0 và false nó làm cho code mình không có được giá trị không mong muốn.
- **Ví dụ:** là nếu bạn đang quản lý một cửa hàng và không muốn các biến 'int' trả về 0 để có thể quản lý các danh mục nào chưa có điền đầy đủ thông tin thì hãy sử dụng biến nullalble để hiển thị là "dữ liệu chưa tồn tại"

## CÁCH SỬ LÝ NULL PHỔ BIẾN:
### **a.nullable (?)**
- các loại kiểu khai biến
```
<kiểu dữ liệu>? tên dữ liệu =  null or dữ liệu;

hoặc

<kiểu dữ liệu>? tên dữ liệu =  new <kiểu dữ liệu>();
```

Ví dụ:

````cs
// ========= input =========

// các kiểu dữ liệu mẫu
int? a = null;
int? b = 1000;
int? c = new int?();

// in ra kết quả
Console.WriteLine("a = {0}", a);
Console.WriteLine("b = {0}", b);
Console.WriteLine("c = {0}", c);

// ========= output =========

a = 
b = 1000
c =

````
**→ khi chúng ta cho nullable giá trị sẽ không trả về gì cả nếu không có số liệu cụ thể.**

Nhưng trong nhiều trường hợp thì mình sẽ bị gặp một vấn là lỗi *NullPointerException* vậy thì sau đây các biến để có thể xử lý NullSafety.

Các biến này sẽ giải quyết được vấn đề *NullReferenceException* khi nullable cố gắng trả về một giá trị nào đó.
### **b. nullable-coditional (?.)**
Biến này sẽ hỗ trợ dùng cho các class member. Còn có 1 biến nữa là **?[]** thì sẽ dùng cho mảng, danh sách.

**Ví dụ:** ở đoạn code này chúng ta sẽ thấy là biến b đang cố gắng lấy độ dài của chuỗi a khi a trả về giá trị là null.
```cs
string a = null;
int? b = a.Lenght;
```
Thì khi đó chúng ta sẽ fix lỗi này bắt cách như sau:
```cs
string a = null;
int? b = a?.Lenght;
```
Lúc này mình đã gán biến ?. vào khi đó thì giá trị s được cho là null và không còn trả về liên tục lấy độ dài chuỗi a nữa và xem giá trị là null.


### **c. Toán tử Elvis (?:)**
Biến này sẽ giúp cho nếu giá trị đó là null thì trả về một giá trị mặc định khác. Thì toán tử này được sử dụng trong Kotlin lập trình android rất phổ biến, có thể hình dung như sau:
nếu bên nào giá trị trả về là null thì sẽ lấy giá trị bên khác nó

    null  ← a → "hello"
    "bye"  ← a → null
Ở đây mình sẽ lấy các giá trị **"hello"** và **"bye"**

Ví dụ:
```Kotlin
val ten: String? = null

<!-- đây là cách nhận biết truyền thống -->
val do_dai: Int
if (ten != null) {
    do_dai = name.length
} else {
    do_dai = 0
}
```
Còn đây là khi sử dụng **?:**
```Kotlin
val do_dai = name?.length ?: 0 
<!-- đơn giản và dễ thực hiện -->
println(do_dai) 
```
Dòng **"val do_dai = name?.length ?: 0"** bạn nghĩ đơn giản là nếu name trả về độ dài có giá trị là null thì giá trị sẽ trả về giá trị là 0.

### **d. hàm let (kết hợp với ?.)**

