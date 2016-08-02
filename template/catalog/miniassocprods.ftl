<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

<#assign associatedProducts = Static["org.ofbiz.order.shoppingcart.product.ProductDisplayWorker"].getRandomCartProductAssoc(request, true)!>
<#if associatedProducts?has_content>
<div id="miniassocproducts" class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.EcommerceYouMightLike}...</h3>
    </div>
    <div class="panel-body">
        <#-- random complementary products -->
        <div class="browsecategorylist">
            <#list associatedProducts as miniProduct>
                    ${setRequestAttribute("miniProdQuantity", 1)}
                    ${setRequestAttribute("miniProdFormName", "theminiassocprod" + miniProduct_index + "form")}
                    ${setRequestAttribute("optProductId", miniProduct.productId)}
                    ${screens.render("component://${activeApp}/widget/CatalogScreens.xml#miniproductsummary")}
            </#list>
        </div>
    </div>
</div>
</#if>
