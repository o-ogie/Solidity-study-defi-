목표
- Defi 에서 많이 활용되는 스마트컨트랙트 3가지에대해 알아보자.

1. UniSwap V2 Pair
- Pair Contract는 유니스왑의 핵심 Contract로 CPMM swap 관련 코드가 들어있다.
- 유니스왑V2 Contract는 Pair Contract뿐만 아니라 거의 모든 swap 서비스에서 사용하고 있다.
- SuchiSwap, PancakeSwap에서도 UniSwap V2 코드를 포크하여 그대로 사용하고 있다.
 

2. Governor Alpha
- 컴파운드 파이낸스에서 개발한 컨트랙트로 DAO 형태의 온체인 거버넌스를 직접 서비스에서 제공할 때
거버너 컨트랙트를 활용하고 있음.
- 역할은 아무거나 올리고 찬성, 반대 투표를 하는데 활용되는 컨트랙트이다.
- 단독으로 활요되는 것보단, 타임락이라는 컨트랙트와 함께 사용이된다.
- 유니스왑과 여러 DAO 프로젝트에서 컴파운드 Governor Alpha Contract를 사용한다.


3. MasterChef
- LP 토큰을 스테이킹 한 유동성 공급자들에게 거버넌스 토큰을 민팅하여 나눠준다.
- MasterChef는 거버넌스 토큰을 민팅하는 유일한 Contract이다.
- 유동성 풀에 할당 포인트를 설정하여 풀마다 지급하는 거버넌스 토큰의 개수를 다르게 할 수 있다.
- MasterChef COntract의 소유자는 TimeLock Contract로 하는 것이 일반 적이다.
- PanCakeSwap 뿐만 아니라 대부분의 Defi Farming 서비스에서 MasterChef 컨트랙트를 그대로 사용할 수 있다.

4. TimeLock & Multicall
- Compound의 TimeLock, MakerDAO의 MultiCall contract 역시 많이 사용된다.
- Time Delay를 두고 트랜잭션이 실행될 필요가 있는 경우에 TimeLock Contact를 활용한다.
ex) 트랜잭션의 변수를 수정하거나 제거하건 어떤 변경사항이 있을때 특정 시간 이후에 실행되도록하고 싶을 때 사용한다.
거버넌스 토큰 보상량을 줄이자는 안건이 올라와서 찬성이 되엇을 시에 바로 적용이 아닌 TimeLock을걸어 기간을 주는 것이다.

- Contract의 owner를 timelock Contract Address로 넘긴다.
- MultiCall은 여러개 트랜잭션을 하나의 함수 호출로 처리하도록 하는 Contract이다.
대표적으로 MakerDao에서 만들어진 MultiCall이 많이 활용된다.
for문을 돌면서 이런 저런 함수를 호출한다고 하면, 블럭이 넘어간느 경우가 생길 수 있다.
예를 들어 블러 생성시간이 1초이고 for문이 다 도는데 2초 이상이 걸린다고하면 다른 블럭에서 데이터를 불러올 가능성이 있다. 이럴 때 사용한다고 한다.

- 이를 활용하면 여러 요청을 동일한 블록에서 결과를 얻을 수 있다는 장점과 통신 횟수를 줄여서 속도에서도 이점을 가지게 된다.
- MasterChef, TimeLock, MultiCall 세개가 하나의 셋트로 Defi에서 많이 활용된다.
