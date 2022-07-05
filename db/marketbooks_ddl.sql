--------------------------------------------------------
--  파일이 생성됨 - 화요일-7월-05-2022
-- 테이블, 시퀀스 생성 쿼리
-- 데이터 임포트는 별도 쿼리 또는 엑셀 파일 사용할 것   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence ADDRESSES_ITEMS_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "ADDRESSES_ITEMS_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 130068 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL
--------------------------------------------------------
--  DDL for Sequence CART_ITEMS_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "CART_ITEMS_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1134 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL
--------------------------------------------------------
--  DDL for Sequence INQUIRIES_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "INQUIRIES_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 41 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL
--------------------------------------------------------
--  DDL for Sequence NOTICES_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "NOTICES_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 56 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL
--------------------------------------------------------
--  DDL for Sequence ORDER_ITEMS_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "ORDER_ITEMS_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 110058 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL
--------------------------------------------------------
--  DDL for Sequence ORDERS_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "ORDERS_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 120046 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL
--------------------------------------------------------
--  DDL for Sequence REVIEWS_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "REVIEWS_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 14 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL
--------------------------------------------------------
--  DDL for Sequence SAMPLE_BOOKS_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "SAMPLE_BOOKS_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 102 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL
--------------------------------------------------------
--  DDL for Sequence USERS_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "USERS_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 120 NOCACHE  NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL
--------------------------------------------------------
--  DDL for Table HTA_BOOK_BESTSELLERS
--------------------------------------------------------

  CREATE TABLE "HTA_BOOK_BESTSELLERS" 
   (	"BEST_RANK" NUMBER(2,0), 
	"BOOK_NO" NUMBER(6,0), 
	"RANK_BEGIN_DATE" DATE, 
	"RANK_END_DATE" DATE
   )
--------------------------------------------------------
--  DDL for Table HTA_BOOK_CATEGORIES
--------------------------------------------------------

  CREATE TABLE "HTA_BOOK_CATEGORIES" 
   (	"CATEGORY_NAME" VARCHAR2(255), 
	"CATEGORY_NO" NUMBER(6,0)
   )
--------------------------------------------------------
--  DDL for Table HTA_BOOK_INQUIRIES
--------------------------------------------------------

  CREATE TABLE "HTA_BOOK_INQUIRIES" 
   (	"INQUIRY_NO" NUMBER(6,0), 
	"USER_NO" NUMBER(6,0), 
	"BOOK_NO" NUMBER(6,0), 
	"INQUIRY_TITLE" VARCHAR2(255), 
	"INQUIRY_CONTENT" CLOB, 
	"INQUIRY_DELETED" CHAR(1) DEFAULT 'N', 
	"INQUIRY_CREATED_DATE" DATE DEFAULT SYSDATE, 
	"INQUIRY_UPDATED_DATE" DATE, 
	"INQUIRY_ANSWER_CONTENT" CLOB, 
	"INQUIRY_ANSWER_CREATED_DATE" DATE DEFAULT SYSDATE, 
	"INQUIRY_ANSWER_UPDATED_DATE" DATE DEFAULT SYSDATE
   )
--------------------------------------------------------
--  DDL for Table HTA_BOOK_REVIEWS
--------------------------------------------------------

  CREATE TABLE "HTA_BOOK_REVIEWS" 
   (	"REVIEW_NO" NUMBER(6,0), 
	"REVIEW_TITLE" VARCHAR2(255), 
	"REVIEW_CONTENT" CLOB, 
	"BOOK_NO" NUMBER(6,0), 
	"USER_NO" NUMBER(6,0), 
	"REVIEW_DELETED" CHAR(1) DEFAULT 'N', 
	"REVIEW_CREATED_DATE" DATE DEFAULT SYSDATE, 
	"REVIEW_UPDATED_DATE" DATE
   )
--------------------------------------------------------
--  DDL for Table HTA_BOOKS
--------------------------------------------------------

  CREATE TABLE "HTA_BOOKS" 
   (	"BOOK_NO" NUMBER(6,0), 
	"CATEGORY_NO" NUMBER(6,0), 
	"BOOK_TITLE" VARCHAR2(255), 
	"BOOK_AUTHOR" VARCHAR2(255), 
	"BOOK_PUBLISHER" VARCHAR2(255), 
	"BOOK_DESCRIPTION" CLOB, 
	"BOOK_PRICE" NUMBER(8,0), 
	"BOOK_DISCOUNT_PRICE" NUMBER(8,0), 
	"BOOK_ON_SELL" CHAR(1) DEFAULT 'Y', 
	"BOOK_STOCK" NUMBER(6,0), 
	"BOOK_CREATED_DATE" DATE DEFAULT SYSDATE, 
	"BOOK_UPDATED_DATE" DATE, 
	"BOOK_DELETED" CHAR(1) DEFAULT 'N'
   )
--------------------------------------------------------
--  DDL for Table HTA_CART_ITEMS
--------------------------------------------------------

  CREATE TABLE "HTA_CART_ITEMS" 
   (	"CART_ITEM_NO" NUMBER(6,0), 
	"USER_NO" NUMBER(6,0), 
	"BOOK_NO" NUMBER(6,0), 
	"CART_ITEM_QUANTITY" NUMBER(6,0), 
	"CART_ITEM_CREATED_DATE" DATE DEFAULT SYSDATE, 
	"CART_ITEM_UPDATED_DATE" DATE
   )
--------------------------------------------------------
--  DDL for Table HTA_INQUIRIES
--------------------------------------------------------

  CREATE TABLE "HTA_INQUIRIES" 
   (	"INQUIRY_NO" NUMBER(6,0), 
	"USER_NO" NUMBER(6,0), 
	"INQUIRY_TITLE" VARCHAR2(255), 
	"INQUIRY_CONTENT" CLOB, 
	"INQUIRY_DELETED" CHAR(1) DEFAULT 'N', 
	"INQUIRY_CREATED_DATE" DATE DEFAULT SYSDATE, 
	"INQUIRY_UPDATED_DATE" DATE, 
	"INQUIRY_ANSWER_CONTENT" CLOB, 
	"INQUIRY_ANSWER_CREATED_DATE" DATE DEFAULT SYSDATE, 
	"INQUIRY_ANSWER_UPDATED_DATE" DATE DEFAULT SYSDATE, 
	"INQUIRY_ANSWER_STATUS" CHAR(1) DEFAULT 'N'
   )
--------------------------------------------------------
--  DDL for Table HTA_NOTICES
--------------------------------------------------------

  CREATE TABLE "HTA_NOTICES" 
   (	"NOTICE_NO" NUMBER(6,0), 
	"NOTICE_TITLE" VARCHAR2(255), 
	"NOTICE_CONTENT" CLOB, 
	"NOTICE_DELETED" CHAR(1) DEFAULT 'N', 
	"NOTICE_CREATED_DATE" DATE DEFAULT SYSDATE, 
	"NOTICE_UPDATED_DATE" DATE DEFAULT SYSDATE, 
	"NOTICE_VIEWCOUNT" NUMBER(6,0) DEFAULT 0
   )
--------------------------------------------------------
--  DDL for Table HTA_ORDER_ITEMS
--------------------------------------------------------

  CREATE TABLE "HTA_ORDER_ITEMS" 
   (	"ORDER_ITEM_NO" NUMBER(6,0), 
	"ORDER_NO" NUMBER(6,0), 
	"BOOK_NO" NUMBER(6,0), 
	"ORDER_ITEM_PRICE" NUMBER(8,0), 
	"ORDER_ITEM_QUANTITY" NUMBER(3,0), 
	"ORDER_ITEM_CREATED_DATE" DATE DEFAULT SYSDATE, 
	"ORDER_ITEM_UPDATED_DATE" DATE
   )
--------------------------------------------------------
--  DDL for Table HTA_ORDERS
--------------------------------------------------------

  CREATE TABLE "HTA_ORDERS" 
   (	"ORDER_NO" NUMBER(6,0), 
	"USER_NO" NUMBER(6,0), 
	"ORDER_TITLE" VARCHAR2(255), 
	"ORDER_TOTAL_PRICE" NUMBER(10,0), 
	"ORDER_TOTAL_QUANTITY" NUMBER(3,0), 
	"ORDER_CREATED_DATE" DATE DEFAULT SYSDATE, 
	"ORDER_UPDATED_DATE" DATE, 
	"ORDER_STATUS" VARCHAR2(255) DEFAULT '결제완료', 
	"ADDRESS_NO" NUMBER(6,0), 
	"ORDER_TOTAL_PAY_PRICE" NUMBER(10,0), 
	"IS_FREE_SHIPPING" CHAR(1) DEFAULT 'N', 
	"ORDER_PAY_METHOD" VARCHAR2(255)
   )
--------------------------------------------------------
--  DDL for Table HTA_USER_ADDRESSES
--------------------------------------------------------

  CREATE TABLE "HTA_USER_ADDRESSES" 
   (	"ADDRESS_NO" NUMBER(6,0), 
	"USER_NO" NUMBER(6,0), 
	"USER_ADDRESS" VARCHAR2(255), 
	"USER_DETAIL_ADDRESS" VARCHAR2(255), 
	"POSTAL_CODE" NUMBER(5,0), 
	"USER_ADDRESS_DELETED" CHAR(1) DEFAULT 'N'
   )
--------------------------------------------------------
--  DDL for Table HTA_USERS
--------------------------------------------------------

  CREATE TABLE "HTA_USERS" 
   (	"USER_NO" NUMBER(6,0), 
	"USER_EMAIL" VARCHAR2(255), 
	"USER_PASSWORD" VARCHAR2(255), 
	"USER_NAME" VARCHAR2(255), 
	"USER_TEL" VARCHAR2(255), 
	"USER_DELETED" CHAR(1) DEFAULT 'N', 
	"USER_CREATED_DATE" DATE DEFAULT SYSDATE, 
	"USER_UPDATED_DATE" DATE, 
	"USER_DEFAULT_AD_NO" NUMBER(6,0)
   )
--------------------------------------------------------
--  DDL for Index SYS_C008640
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYS_C008640" ON "HTA_BOOK_BESTSELLERS" ("BEST_RANK")
--------------------------------------------------------
--  DDL for Index SYS_C008643
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYS_C008643" ON "HTA_BOOK_CATEGORIES" ("CATEGORY_NO")
--------------------------------------------------------
--  DDL for Index SYS_C008648
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYS_C008648" ON "HTA_BOOK_INQUIRIES" ("INQUIRY_NO")
--------------------------------------------------------
--  DDL for Index HTA_REVIEWS_NO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "HTA_REVIEWS_NO_PK" ON "HTA_BOOK_REVIEWS" ("REVIEW_NO")
--------------------------------------------------------
--  DDL for Index HTA_BOOKS_NO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "HTA_BOOKS_NO_PK" ON "HTA_BOOKS" ("BOOK_NO")
--------------------------------------------------------
--  DDL for Index HTA_CART_ITEM_NO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "HTA_CART_ITEM_NO_PK" ON "HTA_CART_ITEMS" ("CART_ITEM_NO")
--------------------------------------------------------
--  DDL for Index SYS_C008652
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYS_C008652" ON "HTA_INQUIRIES" ("INQUIRY_NO")
--------------------------------------------------------
--  DDL for Index SYS_C008655
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYS_C008655" ON "HTA_NOTICES" ("NOTICE_NO")
--------------------------------------------------------
--  DDL for Index HTA_ORDER_ITEMS_NO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "HTA_ORDER_ITEMS_NO_PK" ON "HTA_ORDER_ITEMS" ("ORDER_ITEM_NO")
--------------------------------------------------------
--  DDL for Index HTA_ORDERS_NO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "HTA_ORDERS_NO_PK" ON "HTA_ORDERS" ("ORDER_NO")
--------------------------------------------------------
--  DDL for Index SYS_C008660
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYS_C008660" ON "HTA_USER_ADDRESSES" ("ADDRESS_NO")
--------------------------------------------------------
--  DDL for Index HTA_USER_NO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "HTA_USER_NO_PK" ON "HTA_USERS" ("USER_NO")
--------------------------------------------------------
--  DDL for Index SYS_C008691
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYS_C008691" ON "HTA_USERS" ("USER_EMAIL")
--------------------------------------------------------
--  Constraints for Table HTA_BOOK_BESTSELLERS
--------------------------------------------------------

  ALTER TABLE "HTA_BOOK_BESTSELLERS" MODIFY ("BEST_RANK" NOT NULL ENABLE)
  ALTER TABLE "HTA_BOOK_BESTSELLERS" MODIFY ("BOOK_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_BOOK_BESTSELLERS" MODIFY ("RANK_BEGIN_DATE" NOT NULL ENABLE)
  ALTER TABLE "HTA_BOOK_BESTSELLERS" MODIFY ("RANK_END_DATE" NOT NULL ENABLE)
  ALTER TABLE "HTA_BOOK_BESTSELLERS" ADD PRIMARY KEY ("BEST_RANK")
  USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table HTA_BOOK_CATEGORIES
--------------------------------------------------------

  ALTER TABLE "HTA_BOOK_CATEGORIES" MODIFY ("CATEGORY_NAME" NOT NULL ENABLE)
  ALTER TABLE "HTA_BOOK_CATEGORIES" MODIFY ("CATEGORY_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_BOOK_CATEGORIES" ADD PRIMARY KEY ("CATEGORY_NO")
  USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table HTA_BOOK_INQUIRIES
--------------------------------------------------------

  ALTER TABLE "HTA_BOOK_INQUIRIES" MODIFY ("INQUIRY_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_BOOK_INQUIRIES" MODIFY ("USER_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_BOOK_INQUIRIES" MODIFY ("BOOK_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_BOOK_INQUIRIES" MODIFY ("INQUIRY_CONTENT" NOT NULL ENABLE)
  ALTER TABLE "HTA_BOOK_INQUIRIES" ADD PRIMARY KEY ("INQUIRY_NO")
  USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table HTA_BOOK_REVIEWS
--------------------------------------------------------

  ALTER TABLE "HTA_BOOK_REVIEWS" MODIFY ("REVIEW_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_BOOK_REVIEWS" MODIFY ("BOOK_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_BOOK_REVIEWS" MODIFY ("USER_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_BOOK_REVIEWS" ADD CONSTRAINT "HTA_REVIEWS_NO_PK" PRIMARY KEY ("REVIEW_NO")
  USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table HTA_BOOKS
--------------------------------------------------------

  ALTER TABLE "HTA_BOOKS" MODIFY ("BOOK_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_BOOKS" MODIFY ("CATEGORY_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_BOOKS" MODIFY ("BOOK_TITLE" NOT NULL ENABLE)
  ALTER TABLE "HTA_BOOKS" MODIFY ("BOOK_AUTHOR" NOT NULL ENABLE)
  ALTER TABLE "HTA_BOOKS" MODIFY ("BOOK_PUBLISHER" NOT NULL ENABLE)
  ALTER TABLE "HTA_BOOKS" ADD CONSTRAINT "HTA_BOOKS_NO_PK" PRIMARY KEY ("BOOK_NO")
  USING INDEX  ENABLE
  ALTER TABLE "HTA_BOOKS" MODIFY ("BOOK_STOCK" NOT NULL ENABLE)
--------------------------------------------------------
--  Constraints for Table HTA_CART_ITEMS
--------------------------------------------------------

  ALTER TABLE "HTA_CART_ITEMS" MODIFY ("CART_ITEM_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_CART_ITEMS" MODIFY ("USER_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_CART_ITEMS" MODIFY ("BOOK_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_CART_ITEMS" MODIFY ("CART_ITEM_QUANTITY" NOT NULL ENABLE)
  ALTER TABLE "HTA_CART_ITEMS" ADD CONSTRAINT "HTA_CART_ITEM_NO_PK" PRIMARY KEY ("CART_ITEM_NO")
  USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table HTA_INQUIRIES
--------------------------------------------------------

  ALTER TABLE "HTA_INQUIRIES" MODIFY ("INQUIRY_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_INQUIRIES" MODIFY ("USER_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_INQUIRIES" MODIFY ("INQUIRY_CONTENT" NOT NULL ENABLE)
  ALTER TABLE "HTA_INQUIRIES" ADD PRIMARY KEY ("INQUIRY_NO")
  USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table HTA_NOTICES
--------------------------------------------------------

  ALTER TABLE "HTA_NOTICES" MODIFY ("NOTICE_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_NOTICES" MODIFY ("NOTICE_TITLE" NOT NULL ENABLE)
  ALTER TABLE "HTA_NOTICES" ADD PRIMARY KEY ("NOTICE_NO")
  USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table HTA_ORDER_ITEMS
--------------------------------------------------------

  ALTER TABLE "HTA_ORDER_ITEMS" MODIFY ("ORDER_ITEM_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_ORDER_ITEMS" MODIFY ("ORDER_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_ORDER_ITEMS" MODIFY ("BOOK_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_ORDER_ITEMS" ADD CONSTRAINT "HTA_ORDER_ITEMS_NO_PK" PRIMARY KEY ("ORDER_ITEM_NO")
  USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table HTA_ORDERS
--------------------------------------------------------

  ALTER TABLE "HTA_ORDERS" MODIFY ("ORDER_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_ORDERS" MODIFY ("USER_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_ORDERS" MODIFY ("ORDER_TITLE" NOT NULL ENABLE)
  ALTER TABLE "HTA_ORDERS" MODIFY ("ADDRESS_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_ORDERS" ADD CONSTRAINT "HTA_ORDERS_NO_PK" PRIMARY KEY ("ORDER_NO")
  USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table HTA_USER_ADDRESSES
--------------------------------------------------------

  ALTER TABLE "HTA_USER_ADDRESSES" MODIFY ("ADDRESS_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_USER_ADDRESSES" MODIFY ("USER_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_USER_ADDRESSES" MODIFY ("USER_ADDRESS" NOT NULL ENABLE)
  ALTER TABLE "HTA_USER_ADDRESSES" MODIFY ("POSTAL_CODE" NOT NULL ENABLE)
  ALTER TABLE "HTA_USER_ADDRESSES" ADD PRIMARY KEY ("ADDRESS_NO")
  USING INDEX  ENABLE
--------------------------------------------------------
--  Constraints for Table HTA_USERS
--------------------------------------------------------

  ALTER TABLE "HTA_USERS" MODIFY ("USER_NO" NOT NULL ENABLE)
  ALTER TABLE "HTA_USERS" MODIFY ("USER_EMAIL" NOT NULL ENABLE)
  ALTER TABLE "HTA_USERS" MODIFY ("USER_PASSWORD" NOT NULL ENABLE)
  ALTER TABLE "HTA_USERS" MODIFY ("USER_NAME" NOT NULL ENABLE)
  ALTER TABLE "HTA_USERS" MODIFY ("USER_TEL" NOT NULL ENABLE)
  ALTER TABLE "HTA_USERS" ADD CONSTRAINT "HTA_USER_NO_PK" PRIMARY KEY ("USER_NO")
  USING INDEX  ENABLE
  ALTER TABLE "HTA_USERS" ADD UNIQUE ("USER_EMAIL")
  USING INDEX  ENABLE
--------------------------------------------------------
--  Ref Constraints for Table HTA_BOOK_BESTSELLERS
--------------------------------------------------------

  ALTER TABLE "HTA_BOOK_BESTSELLERS" ADD FOREIGN KEY ("BOOK_NO")
	  REFERENCES "HTA_BOOKS" ("BOOK_NO") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table HTA_BOOK_INQUIRIES
--------------------------------------------------------

  ALTER TABLE "HTA_BOOK_INQUIRIES" ADD FOREIGN KEY ("BOOK_NO")
	  REFERENCES "HTA_BOOKS" ("BOOK_NO") ENABLE
  ALTER TABLE "HTA_BOOK_INQUIRIES" ADD FOREIGN KEY ("USER_NO")
	  REFERENCES "HTA_USERS" ("USER_NO") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table HTA_BOOK_REVIEWS
--------------------------------------------------------

  ALTER TABLE "HTA_BOOK_REVIEWS" ADD CONSTRAINT "HTA_REVIEW_BOOK_NO_FK" FOREIGN KEY ("BOOK_NO")
	  REFERENCES "HTA_BOOKS" ("BOOK_NO") ENABLE
  ALTER TABLE "HTA_BOOK_REVIEWS" ADD CONSTRAINT "HTA_REVIEW_USER_NO_FK" FOREIGN KEY ("USER_NO")
	  REFERENCES "HTA_USERS" ("USER_NO") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table HTA_BOOKS
--------------------------------------------------------

  ALTER TABLE "HTA_BOOKS" ADD FOREIGN KEY ("CATEGORY_NO")
	  REFERENCES "HTA_BOOK_CATEGORIES" ("CATEGORY_NO") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table HTA_CART_ITEMS
--------------------------------------------------------

  ALTER TABLE "HTA_CART_ITEMS" ADD CONSTRAINT "HTA_CARTITEM_BOOK_NO_FK" FOREIGN KEY ("BOOK_NO")
	  REFERENCES "HTA_BOOKS" ("BOOK_NO") ENABLE
  ALTER TABLE "HTA_CART_ITEMS" ADD CONSTRAINT "HTA_CARTITEM_USER_NO_FK" FOREIGN KEY ("USER_NO")
	  REFERENCES "HTA_USERS" ("USER_NO") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table HTA_INQUIRIES
--------------------------------------------------------

  ALTER TABLE "HTA_INQUIRIES" ADD FOREIGN KEY ("USER_NO")
	  REFERENCES "HTA_USERS" ("USER_NO") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table HTA_ORDER_ITEMS
--------------------------------------------------------

  ALTER TABLE "HTA_ORDER_ITEMS" ADD CONSTRAINT "HTA_ORDERITEM_BOOK_NO_FK" FOREIGN KEY ("BOOK_NO")
	  REFERENCES "HTA_BOOKS" ("BOOK_NO") ENABLE
  ALTER TABLE "HTA_ORDER_ITEMS" ADD CONSTRAINT "HTA_ORDERITEM_ORDER_NO_FK" FOREIGN KEY ("ORDER_NO")
	  REFERENCES "HTA_ORDERS" ("ORDER_NO") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table HTA_ORDERS
--------------------------------------------------------

  ALTER TABLE "HTA_ORDERS" ADD FOREIGN KEY ("ADDRESS_NO")
	  REFERENCES "HTA_USER_ADDRESSES" ("ADDRESS_NO") ENABLE
  ALTER TABLE "HTA_ORDERS" ADD CONSTRAINT "HTA_ORDER_USER_NO_FK" FOREIGN KEY ("USER_NO")
	  REFERENCES "HTA_USERS" ("USER_NO") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table HTA_USER_ADDRESSES
--------------------------------------------------------

  ALTER TABLE "HTA_USER_ADDRESSES" ADD FOREIGN KEY ("USER_NO")
	  REFERENCES "HTA_USERS" ("USER_NO") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table HTA_USERS
--------------------------------------------------------

  ALTER TABLE "HTA_USERS" ADD CONSTRAINT "FK_DEFAULT_AD_NO" FOREIGN KEY ("USER_DEFAULT_AD_NO")
	  REFERENCES "HTA_USER_ADDRESSES" ("ADDRESS_NO") ON DELETE CASCADE ENABLE
