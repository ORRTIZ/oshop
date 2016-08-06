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

<#-- NOTE: this template is used for the orderstatus screen in ecommerce AND for order notification emails through the OrderNoticeEmail.ftl file -->
<#-- the "urlPrefix" value will be prepended to URLs by the ofbizUrl transform if/when there is no "request" object in the context -->
<#if baseEcommerceSecureUrl??><#assign urlPrefix = baseEcommerceSecureUrl/></#if>
<#if (orderHeader.externalId)?? && (orderHeader.externalId)?has_content >
  <#assign externalOrder = "(" + orderHeader.externalId + ")"/>
</#if>

<div id="orderHeader">
    <#-- left side -->
    <div class="row">
        <div class="col-md-6">
            <div class="panel">
                
                <div class="panel-body">
                    <#-- placing customer information -->
                    <#if localOrderReadHelper?? && orderHeader?has_content>
                        <#assign displayParty = localOrderReadHelper.getPlacingParty()!/>
                        <#if displayParty?has_content>
                            <#assign displayPartyNameResult = dispatcher.runSync("getPartyNameForDate", Static["org.ofbiz.base.util.UtilMisc"].toMap("partyId", displayParty.partyId, "compareDate", orderHeader.orderDate, "userLogin", userLogin))/>
                        </#if>
                        ${uiLabelMap.PartyName}:
                        <b>${(displayPartyNameResult.fullName)?default("[Name Not Found]")}</b>
                    </#if>
                    <#if distributorId??>
                        ${uiLabelMap.OrderDistributor}: ${distributorId}
                    </#if>
                </div>
            </div>
            <#include "ReviewStatus.ftl"/>
            <#include "ReviewPayment.ftl"/>
        </div>
        
        <#-- right side -->
        <div class="col-md-6">
            <#include "ReviewAddress.ftl"/>
        </div>
    </div>
</div>
