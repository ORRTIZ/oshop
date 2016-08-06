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

<script language="JavaScript" type="text/javascript">
<!--
var clicked = 0;
function processOrder() {
    if (clicked == 0) {
        clicked++;
        //window.location.replace("<@ofbizUrl>processorder</@ofbizUrl>");
        document.${parameters.formNameValue}.processButton.value="${uiLabelMap.OrderSubmittingOrder}";
        document.${parameters.formNameValue}.processButton.disabled=true;
        document.${parameters.formNameValue}.submit();
    } else {
        showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.YoureOrderIsBeingProcessed}");
    }
}
// -->
</script>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">
                <#if maySelectItems?default("N") == "Y" && returnLink?default("N") == "Y" && (orderHeader.statusId)! == "ORDER_COMPLETED" && roleTypeId! == "PLACING_CUSTOMER">
                    <a href="<@ofbizUrl fullPath="true">makeReturn?orderId=${orderHeader.orderId}</@ofbizUrl>" class="submenutextright">${uiLabelMap.OrderRequestReturn}</a>
                </#if>
                ${uiLabelMap.OrderOrder}
                        <#if orderHeader?has_content>
                            ${uiLabelMap.CommonNbr}
                            <a href="<@ofbizUrl fullPath="true">order?orderId=${orderHeader.orderId}</@ofbizUrl>">${orderHeader.orderId}</a>
                            <a href="<@ofbizUrl fullPath="true">order.pdf?orderId=${(orderHeader.orderId)!}</@ofbizUrl>" target="_BLANK" class="btn btn-default btn-xs">PDF</a>
                            <#-- ordered date -->
                            ${uiLabelMap.CommonDate}: 
                            ${orderHeader.orderDate.toString()}
                        </#if>
                        <#if (orderHeader.orderId)??>
                            ${uiLabelMap.CommonInformation} ${externalOrder!} 
                            
                        </#if>
                    </h3>
        <h3 class="panel-title">${uiLabelMap.OrderFinalCheckoutReview}</h3>
        <#if !isDemoStore?? && isDemoStore><p>${uiLabelMap.OrderDemoFrontNote}.</p></#if>
    </>
    <div class="panel-body">
        <#if cart?? && 0 < cart.size()>
            ${screens.render("component://${activeApp}/widget/OrderScreens.xml#orderheader")}
            ${screens.render("component://${activeApp}/widget/OrderScreens.xml#orderitems")}
        <#else>
            <h3>${uiLabelMap.OrderErrorShoppingCartEmpty}.</h3>
        </#if>
        
        <div class="col-md-6 text-left">
            <a href="<@ofbizUrl>showcart</@ofbizUrl>" class="btn btn-warning">${uiLabelMap.OrderBacktoShoppingCart}</a>
        </div>
        <div class="col-md-6 text-right">
            <form type="post" action="<@ofbizUrl>processorder</@ofbizUrl>" name="${parameters.formNameValue}">
                <#if (requestParameters.checkoutpage)?has_content>
                    <input type="hidden" name="checkoutpage" value="${requestParameters.checkoutpage}" />
                </#if>
                <#if (requestAttributes.issuerId)?has_content>
                    <input type="hidden" name="issuerId" value="${requestAttributes.issuerId}" />
                </#if>
                <input type="button" name="processButton" value="${uiLabelMap.OrderSubmitOrder}" onclick="processOrder();" class="btn btn-success" />
            </form>
        </div>
    </div>
    <div align="right">
    </div>
</div>