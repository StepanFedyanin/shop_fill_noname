SELECT product_id,product_name,product_url,product_url_back,product_price FROM clothes.product, clothes.characteristics ,clothes.color, clothes.size, clothes.product_has_size
WHERE characteristics_characteristics_id = characteristics_id 
AND  color_color_id = color_id
AND (size_id = size_size_id1 AND product_id = product_product_id)
AND (characteristics_material = 'хлопок' OR characteristics_material = 'полиэстер')
AND (characteristics_fasteners = 'пуговицы' OR characteristics_fasteners = 'молния')
AND (characteristics_picture = 'вельветовая рубашка' OR characteristics_picture = '1')
AND (characteristics_gender = 'мужской' OR characteristics_gender = '1')
AND (characteristics_season = 'круглогидичный сезон' OR characteristics_season = '1')
AND (characteristics_type = 'рубашка' OR characteristics_type = 'зип-худи')
GROUP BY product_id
;