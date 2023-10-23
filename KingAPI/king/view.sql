CREATE OR REPLACE VIEW  itmesview AS
SELECT items.* , categories.* FROM items 
INNER JOIN  categories on  items.items_cat = categories.categories_id ; 



CREATE OR REPLACE VIEW myfavorite AS 
SELECT favorite.* ,itmes.* ,users.users_id FROM favorite 
INNER JOIN users ON users.users_id = favorite.favorite_userid 
INNER JOIN itmes ON itmes.itmes_id = favorite.favorite_itmesid;
///////////////////////////////////////////////////////////////////////////////////////
CREATE OR REPLACE VIEW cartview AS
SELECT SUM(itmes.itmes_price-itmes.itmes_price* itmes.itmes_discount/100) as totaleprice ,COUNT(cart_itmesid) as totalecount, cart.* , itmes.* FROM `cart`

INNER JOIN itmes ON itmes.itmes_id =cart.cart_itmesid
WHERE cart_orders = 0
GROUP BY cart.cart_userid ,cart.cart_itmesid,cart.cart_orders;

/////////////////////////////////////////////////////////////////////////////////
CREATE OR REPLACE VIEW ordersview AS
SELECT orders.* ,address.* FROM orders
LEFT JOIN address ON address.address_id = orders.orders_addressid;
//////////////////////////////////////////////////////////////////////////////////////////////
CREATE OR REPLACE VIEW ordersdetalisview AS
SELECT SUM(itmes.itmes_price-itmes.itmes_price* itmes.itmes_discount/100) as totaleprice ,COUNT(cart_itmesid) as totalecount,
cart.cart_itemprice - cart.cart_itemprice* cart.cart_itemdiscount/100 as cartitemprice, cart.* , itmes.*  FROM `cart`
INNER JOIN itmes ON itmes.itmes_id =cart.cart_itmesid
WHERE cart_orders != 0
GROUP BY cart.cart_userid ,cart.cart_itmesid,cart.cart_orders;
/*//////////////////////////////////////////////////////////////////////////////////////*/
CREATE OR REPLACE VIEW topsellingview AS
SELECT COUNT(cart.cart_id) AS countselling,cart.*,itmes.* FROM cart 
INNER JOIN itmes on cart.cart_itmesid = itmes.itmes_id 
WHERE cart.cart_orders != 0 GROUP BY cart.cart_itmesid;
