# **Mô Tả**

**Bài tập 2 - Tuần 4** thực hành về tạo Navgation + OOP để có thể tạo ra 4 page chuyển đổi qua từng page và có thể lùi về.

![NhapDung](../sourcecode_bai2/assets/images/bai_tap.jpg)

# **Các Hàm Chính**

## **1. Model & Data**

- **OnboardingModel**: Class định nghĩa cấu trúc dữ liệu (image, title, description)
- **OnboardingData**: Chứa danh sách 3 trang onboarding

## **2. Navigation Functions**

**`_onPageChanged(int index)`**

- Bắt sự kiện vuốt màn hình
- Cập nhật `_currentIndex` để thay đổi UI (chấm tròn, nút Back/Next)

**`_goToNextPage()`**

- Chuyển sang trang tiếp theo
- Nếu ở trang cuối → gọi `_navigateToHome()`

**`_goToPreviousPage()`**

- Quay lại trang trước

**`_skipToLastPage()`**

- Nhảy thẳng đến trang cuối khi bấm "Skip"

**`_navigateToHome()`**

- Kết thúc onboarding, chuyển sang màn hình chính

## **3. UI Components**

**PageIndicator**: 3 chấm tròn chỉ trang hiện tại

**OnboardingContentWidget**: Hiển thị ảnh + title + description

**OnboardingNavigationBar**: Nút Back + Next/Get Started

## **4. State Management**

- **PageController**: Điều khiển PageView và animation
- **\_currentIndex**: Lưu chỉ số trang hiện tại (0-2)

# **Kết Quả**

**Giao diện:**
![NhapDung](../sourcecode_bai2/assets/images/san_pham.png)

![NhapDung](../sourcecode_bai2/assets/images/san_pham1.png)

![NhapDung](../sourcecode_bai2/assets/images/san_pham3.png)
