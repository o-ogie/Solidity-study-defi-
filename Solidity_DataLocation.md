# Data Location
레퍼런스 타입(Reference Type) 또는 다이나믹 타입(Dynamic Type)이라고 부르는 변수들은 솔리디티에서 선언시에 데이터가 저장되는 위치 즉, Data Location을 명시하도록 하고 있다. 명시되지 않는다면 컴파일시 에러를 뱉어낸다.

먼저 레퍼런스 타입에 어떤 타입들이 존재하는지 알아보자. 솔리디티에서는 Array, Structs, Mapping이 레퍼런스 타입에 속한다. 그렇다면 Data Location에는 어떤것들이 있는가? Storage, Memory, Calldata 가 있다. 레퍼런스 타입에 해당하는 변수들은 모두 Storage, Memory, Calldata와 같은 Data Location을 별도로 명시해야 한다.

단, Mapping의 경우 특이하게도 상태 변수와 같이 오직 Storage만 허용된다. Mapping에 관한 내용은 다음에 다시 다뤄보도록 하자.

bytes, string 타입도 special array로 Array 취급을 받는다. 따라서 이러한 타입의 변수들도 동일하게 Data Location을 명시해야 한다.

그렇다면 각 Data Location에는 구체적으로 어떤 차이가 있는가?

Storage — 상태변수(State variable)가 저장되는 공간을 의미한다. 즉, 모든 상태변수들은 Storage에 저장된다. 실제로 블록체인에 저장되는 데이터들이 모두 Storage에 해당한다.

Memory — 메모리는 말 그대로, 함수 호출(External function call)시에만 존재하는 휘발성 데이터가 위치하는 곳을 의미한다.

Calldata — Call에 쓰이는 Data. 즉, 함수 호출시 인자로 포함된 데이터들이 위치하는 공간을 의미한다. Calldata와 Memory의 주요한 차이는 Memory는 수정이 가능하지만, Calldata는 수정이 불가능하다는 것이다.


위 코드 예시를 보면, set 함수에서 myStructs 상태변수를 변경하기 위해서 storage 키워드를 사용하고 있는것을 알 수 있다. 이 때 만약 memory 키워드를 사용하게 된다면, myStruct는 실제 myStructs의 레퍼런스 포인트를 가져오는것이 아니라, 데이터를 카피해서 가져오기 때문에 해당 변수에 아무리 새로운 값을 할당하더라도 myStructs 상태 변수에는 아무런 영향이 없다.

반대로 get 함수에서는 return 타입으로 memory 키워드를 사용하고 있다. 이처럼 직접 상태변수를 변경하지 않고, 읽기만 하거나 또는 데이터를 카피하여 사용하되, 실제 상태변수에는 변화를 주고 싶지 않다면 memory 키워드를 쓰면된다.

Memory vs Calldata
눈썰미가 좋았다면, set 함수에서 string _text가 calldata로 명시되어 있는것을 확인했을 것이다. 이 의미는 “_text라는 레퍼런스 타입(string = special array) 인자를 calldata 영역에 위치해두고 쓰겠습니다”라는 의미다. 만약 _text가 calldata가 아닌 memory 키워드를 사용했다면, 함수의 인자로 전달된 calldata에서 새롭게 메모리로 데이터를 카피하여 사용한다는 의미다.


살짝 헷갈리는데, 솔리디티에서 모든 함수 인자로 전달된 데이터는 트랜잭션의 Data field에 포함된다. Data field는 function identifier, argument 등 함수 호출에 필요한 데이터들이 포함되기 때문에 input data, 또는 calldata 등으로 혼용해서 부른다. 즉, calldata로 표기를 하게 되면, 그대로 calldata에 포함된 데이터를 사용하겠다는 의미이고, memory로 표기를 하게 되면 calldata로 부터 데이터를 가져와 별도의 카피본을 만들어서 사용하겠다는 의미이다.

이렇기에 너무나 당연하게도 calldata가 아닌 memory를 사용하게 되면 필요한 가스가 더 증가한다. 가스는 피같은 돈이기 때문에 가능하면 적게 들수록 좋다. 따라서, 별다른 데이터 수정이 필요하지 않다면 굳이 calldata를 사용하지 않고 memory를 사용할 이유는 없을것이다.

세줄 요약
레퍼런스 타입 변수들을 블록체인에 직접 저장하고, 값을 업데이트 하고 싶으면 storage 를 사용하자.
그냥 읽기만 필요하거나, 블록체인에 상태를 업데이트 할 필요는 없지만, 수정이 필요하다면 memory 를 사용하자.
함수 파라미터로 calldata 키워드를 사용하면 가스를 아낄 수 있다. 따라서, 특별한 이유가 있는게 아니라면 calldata를 쓰자.



------------- 내 정리 --------------

# Data Location
Data Location에는 3가지가 있다.
1. storage
2. memory
3. calldata

레퍼런스 타입에 해당하는 변수들은 모두 Storage, Memory, Calldata와 같은 DataLocation을
별도로 명시해야한다.
## 레퍼런스 타입
1. Array,
2. Struct
3. Mapping
// bytes, string 타입도 special Array로 Array 취급을 받는다. 따라서 이러한 타입의 변수들도 동일하게 Data Location을 명시해줘야한다.

Mapping은 특이하게 상태 변수와 같이 Storage만 허용된다.

## Data Location의 차이

### Storage
- 상태 변수가 저장되는 공간을 의미한다.
즉, 모든 상태변수들은 Storage에 저장됨. 실제로 블록체인에 저장되는 데이터들이 모두 Storage임.


### Memory
- 메모리는 함수 호출 시에만 존재하는 휘발성 데이터가 위치하는 곳을 의미한다.


### Calldata
- call에 쓰이는 Data.
즉, 함수 호출시 인자로 포함된 데이터들이 위치하는 공간을 의미한다. Calldata와 memory의 주요한 차이는 memory는 수정이 가능하지만,
Calldata는 수정이 불가능하다.


`Memory`를 사용하면, 실제 레퍼런스 포인트를 가져오는 것이 아니라, 데이터를 카피해서 가져오기 때문에 해당 변수에 아무리
새로운 값을 할당하고, 변경하더라도 상태변수에는 아무런 영향이 없다.
상태변수를 직접 변경하지 않고, 읽기만 하거나 데이터를 카피하여 사용하되, 실제 상태변수에는 변화를 주고 싶지 않을때  사용하면 된다.

```solidity
function set(address _addr, string calldata _text) external {
        MyStruct storage myStruct = myStructs[_addr];
        myStruct.text = _text;
    }
```

string calldata _text의미는
_text라는 레퍼런스 타입( string = special Array)인자를 calldata영역에 위채해서 사용하겠다는 뜻이다.
만약 calldata가 아니라 memory를 사용했다면, 함수 인자로 전달된 calldata에서 새롭게 메모리로 데이터를 카피하여 사용한다는 의미.

Calldata를 사용하면, calldata에 포함된 데이터를 사용하겠다는 의미이고, memory를 사용하면 calldata로 부터 데이터를 가져와 별도의 카피본을 만들어서 사용하겠다는 의미다.
당연히 카피본을 만드릭 대문에 가스비는 증가하게 된다. => 적게 사용할수록 좋음.
따라서 별다른 데이터 수정이 필요하지 않다면 calldata를 사용허지 않고 memory를 사용할 이유가 없다.

# 세줄 요약
1. 레퍼런스 타입 변수들을 블록체인에 직접 저장하고, 값을 업데이트 하고 싶으면 storage 를 사용하자.
2. 그냥 읽기만 필요하거나, 블록체인에 상태를 업데이트 할 필요는 없지만, 수정이 필요하다면 memory 를 사용하자.
3. 함수 파라미터로 calldata 키워드를 사용하면 가스를 아낄 수 있다. 따라서, 특별한 이유가 있는게 아니라면 calldata를 쓰자.