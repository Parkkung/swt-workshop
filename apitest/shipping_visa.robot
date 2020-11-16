***Settings***
Library    RequestsLibrary
Suite Setup    Create Session    alias=shopping    url=${URL}

***Variables***
${URL}   https://www.dminer.in.th
&{HEADERS}   Content-Type=application/json     Accept=application/json
${DATA}     {"cart" : [{"product_id": 2,"quantity": 1}],"shipping_method" : "Kerry","shipping_address" : "405/37 ถ.มหิดล","shipping_sub_district" : "ต.ท่าศาลา","shipping_district" : "อ.เมือง","shipping_province" : "จ.เชียงใหม่","shipping_zip_code" : "50000","recipient_name" : "ณัฐญา ชุติบุตร","recipient_phone_number" : "0970809292"}
${DATA2}    {"order_id" : 8004359122,"payment_type" : "credit","type" : "visa","card_number" : "4719700591590995","cvv" : "752","expired_month" : 7,"expired_year" : 20,"card_name" : "Karnwat Wongudom","total_price" : 14.95}
***Test Cases***
buy toy for daughter
    Search product
    Product detail
    Submit Order
    Confirm payment

***Keywords***

Search product
    ${resp}    Get Request    alias=shopping    uri=/api/v1/product
    Request Should be successful    ${resp}
    Should Be Equal As Integers   ${resp.json()['total']}   2
    Should Be Equal As Strings   ${resp.json()['products'][1]['product_name']}   43 Piece dinner Set

Product detail
    ${resp}    Get Request    alias=shopping    uri=/api/v1/product/2   headers=${HEADERS}
    Request Should be successful    ${resp}
    Should Be Equal As Integers     ${resp.json()['id']}    2
    Should Be Equal   ${resp.json()['product_name']}   43 Piece dinner Set
    Should Be Equal As Numbers     ${resp.json()['product_price']}    12.95
    Should Be Equal   ${resp.json()['product_image']}   /43_Piece_dinner_Set.png
    Should Be Equal As Integers     ${resp.json()['quantity']}    10
    Should Be Equal    ${resp.json()['product_brand']}   CoolKidz

Submit Order
    ${data}     To Json     ${DATA}
    ${resp}     Post Request    alias=shopping      uri=/api/v1/order   headers=${HEADERS}  json=${data}
    Request Should be successful    ${resp}
    Should Be Equal As Integers     ${resp.json()['order_id']}      8004359122
    Should Be Equal As Numbers     ${resp.json()['total_price']}    14.95
    Set Test Variable      ${ORDER_ID}     ${resp.json()['order_id']}

Confirm payment
    ${data}     To Json     ${DATA2}
    ${resp}     Post Request    alias=shopping      uri=/api/v1/confirmPayment      headers=${HEADERS}      json=${data}
    Request Should be successful    ${resp}
    Should Be Equal    ${resp.json()['notify_message']}   วันเวลาที่ชำระเงิน 1/3/2020 13:30:00 หมายเลขคำสั่งซื้อ ${ORDER_ID} คุณสามารถติดตามสินค้าผ่านช่องทาง Kerry หมายเลข 1785261900