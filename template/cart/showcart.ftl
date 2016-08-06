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
<script type="text/javascript">
//<![CDATA[
function toggle(e) {
    e.checked = !e.checked;
}
function checkToggle(e) {
    var cform = document.cartform;
    if (e.checked) {
    var len = cform.elements.length;
    var allchecked = true;
        for (var i = 0; i < len; i++) {
            var element = cform.elements[i];
            if (element.name == "selectedItem" && !element.checked) {
                allchecked = false;
            }
            cform.selectAll.checked = allchecked;
        }
    } else {
        cform.selectAll.checked = false;
    }
}
function toggleAll(e) {
    var cform = document.cartform;
    var len = cform.elements.length;
    for (var i = 0; i < len; i++) {
        var element = cform.elements[i];
        if (element.name == "selectedItem" && element.checked != e.checked) {
            toggle(element);
        }
    }
}
function removeSelected() {
    var cform = document.cartform;
    cform.removeSelected.value = true;
    cform.submit();
}
function addToList() {
    var cform = document.cartform;
    cform.action = "<@ofbizUrl>addBulkToShoppingList</@ofbizUrl>";
    cform.submit();
}
function gwAll(e) {
    var cform = document.cartform;
    var len = cform.elements.length;
    var selectedValue = e.value;
    if (selectedValue == "") {
        return;
    }

    var cartSize = ${shoppingCartSize};
    var passed = 0;
    for (var i = 0; i < len; i++) {
        var element = cform.elements[i];
        var ename = element.name;
        var sname = ename.substring(0,16);
        if (sname == "option^GIFT_WRAP") {
            var options = element.options;
            var olen = options.length;
            var matching = -1;
            for (var x = 0; x < olen; x++) {
                var thisValue = element.options[x].value;
                if (thisValue == selectedValue) {
                    element.selectedIndex = x;
                    passed++;
                }
            }
        }
    }
    if (cartSize > passed && selectedValue != "NO^") {
        showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.EcommerceSelectedGiftWrap}");
    }
    cform.submit();
}
//]]>
</script>

<script type="text/javascript">
//<![CDATA[
function setAlternateGwp(field) {
  window.location=field.value;
};
//]]>
</script>
<#assign fixedAssetExist = shoppingCart.containAnyWorkEffortCartItems() /> <#-- change display format when rental items exist in the shoppingcart -->
<div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">${uiLabelMap.OrderShoppingCart}</h3>
        </div>
        <div class="panel-body">
            <#include "CartQuickAddProduct.ftl" />
            <#if ((sessionAttributes.lastViewedProducts)?has_content && sessionAttributes.lastViewedProducts?size > 0)>
                <#assign continueLink = "/product?product_id=" + sessionAttributes.lastViewedProducts.get(0) />
            <#else>
                <#assign continueLink = "/main" />
            </#if>
            <a href="<@ofbizUrl>${continueLink}</@ofbizUrl>" class="btn btn-warning btn-sm">${uiLabelMap.EcommerceContinueShopping}</a>
            <script type="text/javascript">
                //<![CDATA[
                document.quickaddform.add_product_id.focus();
                //]]>
            </script>
            <#--<a href="<@ofbizUrl>main</@ofbizUrl>" class="lightbuttontext">[${uiLabelMap.EcommerceContinueShopping}]</a>-->
            <#if (shoppingCartSize > 0)>
                <a href="javascript:document.cartform.submit();" class="btn btn-default btn-xs">${uiLabelMap.EcommerceRecalculateCart}</a>
                <a href="<@ofbizUrl>emptycart</@ofbizUrl>" class="btn btn-default btn-xs">${uiLabelMap.EcommerceEmptyCart}</a>
                <a href="javascript:removeSelected();" class="btn btn-default btn-xs">${uiLabelMap.EcommerceRemoveSelected}</a>
            </#if>
            <#if (shoppingCartSize > 0)>
                <form method="post" action="<@ofbizUrl>modifycart</@ofbizUrl>" name="cartform">
                    <fieldset>
                        <input type="hidden" name="removeSelected" value="false" />
                        <#include "CartItems.ftl" />
                        <#include "CartItemAdjustments.ftl" />
                        <#include "CartAddPromo.ftl" />
                        <#include "CartShowPromo.ftl" />
                    </fieldset>
                </form>
            <#if (shoppingCartSize > 0)>
                <div class="col-md-12 text-right">
                <a href="<@ofbizUrl>checkoutoptions</@ofbizUrl>" class="btn btn-success btn-sm">${uiLabelMap.OrderCheckout}</a>
                </div>
            <#else>
                <span class="submenutextrightdisabled">${uiLabelMap.OrderCheckout}</span>
            </#if>
            <#else>
                <h2>${uiLabelMap.EcommerceYourShoppingCartEmpty}.</h2>
            </#if>
        </div>
    </div>


<#if associatedProducts?has_content>
    <#include "CartAssocProducts.ftl" />
</#if>

<!-- Internal cart info: productStoreId=${shoppingCart.getProductStoreId()!} locale=${shoppingCart.getLocale()!} currencyUom=${shoppingCart.getCurrency()!} userLoginId=${(shoppingCart.getUserLogin().getString("userLoginId"))!} autoUserLogin=${(shoppingCart.getAutoUserLogin().getString("userLoginId"))!} -->
