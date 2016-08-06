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
<#if orderHeader?has_content>
  <form name="addCommonToCartForm" action="<@ofbizUrl>addordertocart/order</@ofbizUrl>" method="post">
    <input type="hidden" name="add_all" value="false" />
    <input type="hidden" name="orderId" value="${orderHeader.orderId}" />
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
                </div>
        <div class="panel-body">
            ${screens.render("component://${activeApp}/widget/OrderScreens.xml#orderheader")}
            ${screens.render("component://${activeApp}/widget/OrderScreens.xml#orderitems")}
        </div>
    </div>
  </form>

<#else>
  <h3>${uiLabelMap.OrderSpecifiedNotFound}.</h3>
</#if>
