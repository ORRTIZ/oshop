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
<#if sessionAttributes.userLogin?has_content && sessionAttributes.userLogin.userLoginId != "anonymous">
    <hr />
    <form name="addToShoppingList" method="post" action="<@ofbizUrl>addItemToShoppingList<#if requestAttributes._CURRENT_VIEW_??>/${requestAttributes._CURRENT_VIEW_}</#if></@ofbizUrl>">
        <fieldset>
            <input type="hidden" name="productId" value="${product.productId}" />
            <input type="hidden" name="product_id" value="${product.productId}" />
            <input type="hidden" name="productStoreId" value="${productStoreId}" />
            <input type="hidden" name="reservStart" value= "" />
            <select name="shoppingListId">
                <#if shoppingLists?has_content>
                    <#list shoppingLists as shoppingList>
                        <option value="${shoppingList.shoppingListId}">${shoppingList.listName}</option>
                    </#list>
                </#if>
                <option value="">---</option>
                <option value="">${uiLabelMap.OrderNewShoppingList}</option>
            </select>
            &nbsp;&nbsp;
            
            <#--assign nowDate = Static["org.ofbiz.base.util.UtilDateTime"].nowDateString("yyyy-MM-dd")-->
            <#if product.productTypeId! == "ASSET_USAGE">
                &nbsp;${uiLabelMap.CommonStartDate} (yyyy-mm-dd)<@htmlTemplate.renderDateTimeField name="reservStartStr" event="" action="" value="${startDate}" className="" alert="" title="Format: yyyy-MM-dd HH:mm:ss.SSS" size="15" maxlength="30" id="reservStartStr" dateType="date" shortDateInput=false timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>&nbsp;Number of&nbsp;days&nbsp;&nbsp;<input type="text" size="4" name="reservLength" />&nbsp;<br/>Number of&nbsp;persons&nbsp;&nbsp;<input type="text" size="4" name="reservPersons" value="1" />&nbsp;&nbsp;Qty&nbsp;&nbsp;<input type="text" size="5" name="quantity" value="1" />
            <#elseif product.productTypeId! == "ASSET_USAGE_OUT_IN">
                &nbsp;${uiLabelMap.CommonStartDate} (yyyy-mm-dd)&nbsp;&nbsp;&nbsp;<@htmlTemplate.renderDateTimeField name="reservStartStr" event="" action="" value="${startDate}" className="" alert="" title="Format: yyyy-MM-dd HH:mm:ss.SSS" size="15" maxlength="30" id="reservStartStr" dateType="date" shortDateInput=false timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>&nbsp;&nbsp;Number of&nbsp;days&nbsp;&nbsp;<input type="text" size="4" name="reservLength" /><input type="hidden" size="4" name="reservPersons" value="1" /><br/>
                Qty&nbsp;<input type="text" size="5" name="quantity" value="1" />
            <#else>
                <input type="text" size="5" name="quantity" value="1" />
                <input type="hidden" name="reservStartStr" value= "" />
            </#if>
            <a href="javascript:addShoplistSubmit();" class="buttontext">${uiLabelMap.OrderAddToShoppingList}</a>
        </fieldset>
    </form>
<#else>
    <br />
    ${uiLabelMap.OrderYouMust} <a href="<@ofbizUrl>checkLogin/showcart</@ofbizUrl>" class="buttontext">${uiLabelMap.CommonBeLogged}</a>
    ${uiLabelMap.OrderToAddSelectedItemsToShoppingList}.&nbsp;
</#if>