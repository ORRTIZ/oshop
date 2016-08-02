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

<#if party??>
<#-- Main Heading -->
<div class="panel panel-default">
<div class="panel-heading">
<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr>
    <td>
      <h2 class="panel-title">${uiLabelMap.PartyTheProfileOf}
        <#if person??>
          ${person.personalTitle!}
          ${person.firstName!}
          ${person.middleName!}
          ${person.lastName!}
          ${person.suffix!}
        <#else>
          "${uiLabelMap.PartyNewUser}"
        </#if>
      </h2>
    </td>
    <td align="right">
      <#if showOld>
        <a href="<@ofbizUrl>viewprofile</@ofbizUrl>" class="button">${uiLabelMap.PartyHideOld}</a>
      <#else>
        <a href="<@ofbizUrl>viewprofile?SHOW_OLD=true</@ofbizUrl>" class="btn btn-default btn-sm">${uiLabelMap.PartyShowOld}</a>
      </#if>
      <#if (productStore.enableDigProdUpload)! == "Y">
        <a href="<@ofbizUrl>digitalproductlist</@ofbizUrl>" class="button">${uiLabelMap.EcommerceDigitalProductUpload}</a>
      </#if>
    </td>
  </tr>
</table>
</div>
<div class="panel-body">
<div id="profileDetailBox" class="row">
    <div class="col-md-3">
        <ul class="nav nav-pills nav-stacked">
            <li class="active"><a data-toggle="tab" href="#Account">${uiLabelMap.PartyAccount}</a></li>
            <li><a data-toggle="tab" href="#ContactMechs">${uiLabelMap.PartyContactInformation}</a></li>
            <li><a data-toggle="tab" href="#PaymentMechs">Billing Info</a></li>
            <li><a data-toggle="tab" href="#LoyalityPoints">${uiLabelMap.EcommerceLoyaltyPoints}</a></li>
            <li><a data-toggle="tab" href="#Orders">${uiLabelMap.CommonOrders}</a></li>
            <li><a data-toggle="tab" href="#Messages">${uiLabelMap.CommonMessages}</a></li>
            <li><a data-toggle="tab" href="#Surveys">${uiLabelMap.CommonSurveys}</a></li>
        </ul>
    </div>
    <div class="col-md-9">
        <div class="tab-content">
            <div id="Account" class="tab-pane fade in active">
                <#include "AccountName.ftl" />
            </div>
            <div id="LoyalityPoints" class="tab-pane fade">
                <#include "AccountLoyalityPoints.ftl" />
            </div>
            <div id="Orders" class="tab-pane fade">
                ${screens.render("component://oshop/widget/OrderScreens.xml#orderhistory")}
            </div>
            <div id="Messages" class="tab-pane fade">
                <#include "AccountMessages.ftl" />
            </div>
            <div id="Surveys" class="tab-pane fade">
                <#include "AccountSurveys.ftl" />
            </div>
            <div id="ContactMechs" class="tab-pane fade">
                <#include "AccountContactMechs.ftl" />
            </div>
            <div id="PaymentMechs" class="tab-pane fade">
                <#include "AccountCards.ftl" />
            </div>
        </div>
    </div>
</div>
</div>
</div>
<#-- ============================================================= -->
<#-- only 5 messages will show; edit the ViewProfile.groovy to change this number -->
${screens.render("component://${activeApp}/widget/CustomerScreens.xml#FinAccountList-include")}

<#-- Serialized Inventory Summary -->
${screens.render('component://${activeApp}/widget/CustomerScreens.xml#SerializedInventorySummary')}

<#-- Subscription Summary -->
${screens.render('component://${activeApp}/widget/CustomerScreens.xml#SubscriptionSummary')}

<#-- Reviews -->
${screens.render('component://${activeApp}/widget/CustomerScreens.xml#showProductReviews')}

<#else>
    <h3>${uiLabelMap.PartyNoPartyForCurrentUserName}: ${userLogin.userLoginId}</h3>
</#if>
