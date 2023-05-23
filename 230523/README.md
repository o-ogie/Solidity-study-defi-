# Cra

```sh
npx create-react-app metamask
```

node에는 3개의 포트가 열려있고
2개는 클라이언트로 요청으로 사용되고 하나는 노드끼리 통신하는데 사용된다.

어제 했던 것. local pc에서 node로 요청을 날리는 코드.

private key가 잇어야 서명을 할 수 있다.

wallet에서 브라우저에서 데이터를 받고 서명만해서 노드로 요청을 보내는 역할을 한다.



## Message or Transaction

```js
const tx = {
    //browser
    from:"",
    to:"",
    value:"",
    gas:"",
    gassPrice:"",

    // wallet
    r:"",
    s:"",
    v:""
}
```

