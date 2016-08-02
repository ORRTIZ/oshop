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
<div class="panel">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.ProductPromoCodes}</h3>
    </div>
    <div class="panel-body">
        <form method="post" action="<@ofbizUrl>addpromocode<#if requestAttributes._CURRENT_VIEW_?has_content>/${requestAttributes._CURRENT_VIEW_}</#if></@ofbizUrl>" name="addpromocodeform">
            <fieldset>
            <input type="text" class="inputBox" size="15" name="productPromoCodeId" value="" />
            <input type="submit" class="btn btn-success btn-sm" value="${uiLabelMap.OrderAddCode}" />
            <#assign productPromoCodeIds = (shoppingCart.getProductPromoCodesEntered())! />
            <#if productPromoCodeIds?has_content>
                ${uiLabelMap.ProductPromoCodesEntered}
                <ul>
                <#list productPromoCodeIds as productPromoCodeId>
                    <li>${productPromoCodeId}</li>
                </#list>
                </ul>
            </#if>
            <#if (shoppingCartSize?default(0) > 0)>
                ${screens.render("component://oshop/widget/CartScreens.xml#promoUseDetailsInline")}
            </#if>
            </fieldset>
        </form>
    </div>
</div>