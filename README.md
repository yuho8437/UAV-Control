# UAV Control Projects

UNIST 2019 2학기 UAV Navigation & Flight Computer 과목에서 구현하였던 프로젝트입니다.

프로젝트 1의 C/A Code generator는 Fundamentals of Global Positioning System Receivers 책의 

Chapter 5를 참고하였고, 프로젝트 2의 전체적인 closed-loop system design은 수업 슬라이드를 참고하였습니다.

## 프로젝트 개요

### Project1: GPS C/A Code generator & Correlation

1. C/A Code generator implementation example

![img](./img/1-1.png)

2. Auto-correlation, Cross-correlation implementation example

![img](./img/autocorr.png)

![img](./img/crosscorr.png)

### Project2: UGV control simulation (2D) - with closed-loop system

1. Problem situation
   - 임의로 destination 입력 시, wheel motor를 컨트롤하여 해당 지점까지 이동하고 parallel parking 수행

![image](./img/그림1.png)

2. Control system design (*Lecture slides recommendation)

![image](./img/그림2.png)

3. Implementation

![image](./img/그림3.png)

### project3: UAV stabilizing simulation (2D) - with closed-loop system

1. Problem situation (Fixed on the rod)
   - 임의의 각도 phi를 입력 시, propeller motor를 컨트롤하여 stabilizing 수행

![image](./img/그림4.png)

2. Control system design (*My control system design)

![image](./img/그림5.png)

![image](./img/그림9.png)

![image](./img/그림10.png)

3. Implementation

![image](./img/그림6.png)

![image](./img/그림8.png)

## 참고 문헌

- Project 1: "Fundamentals of Global Positioning System Receivers - A Software Approach (James Bao‐Yen Tsui)" chapter5. GPS C/A Code Signal Structure
