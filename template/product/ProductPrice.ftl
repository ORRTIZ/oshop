<#--
(C) Copyright 2015 Somonar B.V.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.

 -->
<#-- for prices:
- if price < competitivePrice, show competitive or "Compare At" price
- if price < listPrice, show list price
- if price < defaultPrice and defaultPrice < listPrice, show default
- if isSale show price with salePrice style and print "On Sale!"
-->

<!-- competitive price -->
<#if price.competitivePrice?? && price.price?? && price.price &lt; price.competitivePrice>
    <div>
        ${uiLabelMap.ProductCompareAtPrice}: <span class="basePrice"><@ofbizCurrency amount=price.competitivePrice isoCode=price.currencyUsed /></span>
    </div>
</#if>
<!-- list price -->
<#if price.listPrice?? && price.price?? && price.price &lt; price.listPrice>
    <div>
        ${uiLabelMap.ProductListPrice}: <span class="basePrice"><@ofbizCurrency amount=price.listPrice isoCode=price.currencyUsed /></span>
    </div>
</#if>
<#if price.listPrice?? && price.defaultPrice?? && price.price?? && price.price &lt; price.defaultPrice && price.defaultPrice &lt; price.listPrice>
    <div>
        ${uiLabelMap.ProductRegularPrice}: <span class="basePrice"><@ofbizCurrency amount=price.defaultPrice isoCode=price.currencyUsed /></span>
    </div>
</#if>
<!-- special promo price -->
<#if price.specialPromoPrice??>
    <div>
        ${uiLabelMap.ProductSpecialPromoPrice}: <span class="basePrice"><@ofbizCurrency amount=price.specialPromoPrice isoCode=price.currencyUsed /></span>
    </div>
</#if>
<!-- sale price -->
<div>
    <strong>
        <#if price.isSale?? && price.isSale>
            <br/>
            <span class="salePrice">${uiLabelMap.OrderOnSale}!</span>
            <#assign priceStyle = "salePrice" />
        <#else>
            <#assign priceStyle = "regularPrice" />
        </#if>
    </strong>
    ${uiLabelMap.OrderYourPrice}: 
    <strong>
        <#if "Y" = product.isVirtual!> ${uiLabelMap.CommonFrom} </#if>
        <span class="${priceStyle}"><@ofbizCurrency amount=price.price isoCode=price.currencyUsed /></span>
        <#if product.productTypeId! == "ASSET_USAGE" || product.productTypeId! == "ASSET_USAGE_OUT_IN">
            <#if product.reserv2ndPPPerc?? && product.reserv2ndPPPerc != 0><br />
                <span class="${priceStyle}">${uiLabelMap.ProductReserv2ndPPPerc}<#if !product.reservNthPPPerc?? || product.reservNthPPPerc == 0>${uiLabelMap.CommonUntil} ${product.reservMaxPersons!1}</#if> <@ofbizCurrency amount=product.reserv2ndPPPerc*price.price/100 isoCode=price.currencyUsed /></span>
            </#if>
            <#if product.reservNthPPPerc?? &&product.reservNthPPPerc != 0><br />
                <span class="${priceStyle}">${uiLabelMap.ProductReservNthPPPerc} <#if !product.reserv2ndPPPerc?? || product.reserv2ndPPPerc == 0>${uiLabelMap.ProductReservSecond} <#else> ${uiLabelMap.ProductReservThird} </#if> ${uiLabelMap.CommonUntil} ${product.reservMaxPersons!1}, ${uiLabelMap.ProductEach}: <@ofbizCurrency amount=product.reservNthPPPerc*price.price/100 isoCode=price.currencyUsed /></span>
            </#if>
            <#if (!product.reserv2ndPPPerc?? || product.reserv2ndPPPerc == 0) && (!product.reservNthPPPerc?? || product.reservNthPPPerc == 0)>
                <br />${uiLabelMap.ProductMaximum} ${product.reservMaxPersons!1} ${uiLabelMap.ProductPersons}.
            </#if>
        </#if>
    </strong>
</div>

<!-- list price -->
<#if price.listPrice?? && price.price?? && price.price &lt; price.listPrice>
    <br/>
    <#assign priceSaved = price.listPrice - price.price />
    <#assign percentSaved = (priceSaved / price.listPrice) * 100 />
    <div>
        ${uiLabelMap.OrderYouSave}: <strong><span class="basePrice"><@ofbizCurrency amount=priceSaved isoCode=price.currencyUsed /> (${percentSaved?int}%)</span></strong>
    </div>
</#if>

<#-- show price details ("showPriceDetails" field can be set in the screen definition) -->
<#if (showPriceDetails?? && showPriceDetails?default("N") == "Y")>
    <#if price.orderItemPriceInfos??>
        <#list price.orderItemPriceInfos as orderItemPriceInfo>
            <div>
                ${orderItemPriceInfo.description!}
            </div>
        </#list>
    </#if>
</#if>