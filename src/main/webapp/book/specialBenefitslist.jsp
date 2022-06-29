<%@page import="java.util.Date"%>
<%@page import="vo.Book"%>
<%@page import="java.util.List"%>
<%@page import="vo.Pagination"%>
<%@page import="dao.BookDao"%>
<%@page import="util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="container">
<div class="page_aticle">
<div id="mainEvent" class="page_section section_event">
<ul class="list">
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=619" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/65b6923ad31baa9d3fa2f3ed61d80ebc.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=688" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/75db89278537d27ea3593917ed5e7427.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=585" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/749a75332f2c19a3029011f31f863d5a.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=564" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/f7547fcb16b5227f99363e9ba0279bbb.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=643" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/4ee81b884b0302d4b81b882f1a38a5d4.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=586" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/9bf48a0b2672aaafdd3c3a4ed5bb74ec.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=717" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/c81fa648bb261654b536b1e9dfce1801.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=561" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/394e77c9f0b91b296a55d2a07c77b5bc.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=580" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/e352dfe7d40dc1d162940b15572edc38.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=589" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/460413c69428859e03b2ca99b1b2d4e5.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=567" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/7330ba405eb2c9c61dbc2c51b83b4eeb.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/event/kurlyEvent.php?htmid=event/2022/0623/pet" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/694139dfe01c4dbca96e18d08e5662db.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=581" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/26bbedd74525d030bb570ecf53f1737f.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=571" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/6adc997595a5c134c7d35e7fce012418.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=587" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/72c18414b35c5cc0208e5f1170cbfd00.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=627" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/7c5727d3ab10710e1d7ff3eb79ff1029.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=711" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/e4ad582595aa3184acf1a64c39e3f785.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=582" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/aaf916ef217000d8ec27431e89499d47.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=626" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/88e034996ad6039afd0145cb355abad8.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=578" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/815ed941ae4c5e425de9d945c6a616c6.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=579" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/3f52d4cb1daacb4bf1f33ac9e10f42b3.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=566" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/ce4650fccd707e8ef42890c364fb8db8.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=584" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/b63afe819f4e76bc1f68caf86fd7e915.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=569" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/33b487f991ce28b89d55b274337675f7.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=588" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/501014d8489d6202982731423aa302f7.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=625" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/0f66c98d5be5b375be29ea43ff31c9cc.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=604" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/9e668f22eb6abe696a06b0310a91feab.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=572" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/b901b0c220fda04224a9c89750fecde7.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=562" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/8cb1cdc982764ff154aeb112b50213f5.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=621" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/19273aa4637b6ff943eed7716809fad8.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=568" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/d7053a100fe4c4010c340019b98fb40a.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=570" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/90eb8f127913f1af432141f01d08fea1.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=659" data-git="127107">
<img src="//img-cf.kurly.com/shop/data/event/224a9e2a86b120b9e6605ab8be53aec6.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=620" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/c6fb489207ad1f594d748dfba8ea9d5c.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=565" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/e1d1f490fe3984a227cc4405a4e752d9.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=761" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/6a26c8fe5b750cae5f5f098cc4e96832.jpg" alt="">
</a>
 </li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=577" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/76175bace21ed32afe667dbe4c307a91.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=773" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/149097d2a92a55a471459f25e2a7a797.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=573" data-git="70927">
<img src="//img-cf.kurly.com/shop/data/event/ca8c4f319d1062a82635647e6d93a7bd.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=563" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/2025f75852b9b4306e0b999fcc3e6499.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=576" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/a7e7fe39e92c099f0cd3faf4b56575e1.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=774" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/36ec713efb4983f8b24a4c1d9cdc56cb.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=771" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/430c7cdcdba00868457105068ab4db3f.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=769" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/f300144e99550b0187e594da2db48db5.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=574" data-git="152032">
<img src="//img-cf.kurly.com/shop/data/event/8413233dc435306c7c464e7b16d6742d.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=359" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/4af8b1290fc5d26b954ce37ac5f96df4.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_list.php?category=712" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/daf8c9478429caf1240ab09130a98e27.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/goods/goods_view.php?&amp;goodsno=148452" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/960a4402c17cfb3ef95dd95cc095828a.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/main/html.php?htmid=event/kurly.htm&amp;name=basket" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/2a5bd33bf3b649035509d1f144c0cc4d.jpg" alt="">
</a>
</li>
<li>
<a href="https://kurly.com/shop/main/html.php?htmid=event/kurly.htm&amp;name=tosspay" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/0d6f32889050ff26d81d9a47d7b8a440.jpg" alt="">
</a>
</li>
<li>
<a href="https://kurly.com/shop/main/html.php?htmid=event/kurly.htm&amp;name=payco" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/c6d43f3ca38ce74646fcfa8f97657ef8.jpg" alt="">
</a>
</li>
<li>
<a href="https://kurly.com/shop/main/html.php?htmid=event/kurly.htm&amp;name=spay" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/2499c56a5eaffd17dc83882d34140e16.png" alt="">
</a>
</li>
<li>
<a href="https://kurly.com/shop/main/html.php?htmid=event/kurly.htm&amp;name=chai" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/eec02b74ce5e281e31a8c249f2b94f24.png" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/main/html.php?htmid=event/kurly.htm&amp;name=friend" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/d65da984e840aa37604a1b7bf711f88d.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/event/kurlyEvent.php?htmid=event/2021/0903/fresh" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/2f67ab8eb81c277295084bb3a8577cf8.jpg" alt="">
</a>
</li>
<li>
<a href="https://www.kurly.com/shop/main/html.php?htmid=event/kurly.htm&amp;name=lovers" data-git="">
<img src="//img-cf.kurly.com/shop/data/event/49735d41e380f788499ea23cbdb0cfd8.jpg" alt="">
</a>
</li>
</ul>
</div>
</div>
</div>