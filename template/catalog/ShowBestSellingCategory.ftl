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

<#if productCategoryList?has_content>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">Popular Categories</h3>
        </div>
        <div class="panel-body">
            <div class="productsummary-container matrix">
            <table class="table">
            <tbody>
            <#list productCategoryList as childCategoryList>
                <div class="row">
                    <#assign cateCount = 0/>
                    <#list childCategoryList as productCategory>
                       <#if (cateCount > 2)>
                            <div class="row">
                            <#assign cateCount = 0/>
                       </#if>
                       <#assign productCategoryId = productCategory.productCategoryId/>
                       <#assign categoryImageUrl = "/images/defaultImage.jpg">
                       <#assign productCategoryMembers = delegator.findByAnd("ProductCategoryAndMember", Static["org.ofbiz.base.util.UtilMisc"].toMap("productCategoryId", productCategoryId), Static["org.ofbiz.base.util.UtilMisc"].toList("-quantity"), false)>
                       
                       <#if productCategory.categoryImageUrl?has_content>
                            <#assign categoryImageUrl = productCategory.categoryImageUrl/>
                       <#elseif productCategoryMembers?has_content>
                            <#assign productCategoryMember = Static["org.ofbiz.entity.util.EntityUtil"].getFirst(productCategoryMembers)/>
                            <#assign product = delegator.findOne("Product", Static["org.ofbiz.base.util.UtilMisc"].toMap("productId", productCategoryMember.productId), false)/>
                            <#if product.smallImageUrl?has_content>
                                <#assign categoryImageUrl = product.smallImageUrl/>
                            </#if>
                       </#if>
                       <!-- showing the category -->
                        <td valign="top">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="panel-image">
                                    <a href="<@ofbizCatalogAltUrl productCategoryId=productCategoryId/>">
                                        <span class="popup_link"><img class="img-thumbnail" src="${categoryImageUrl}"></span>
                                    </a>
                                    </div>
                                    <div class="panel-title">
                                        <a class="linktext title"  style="font-size:12px" href="<@ofbizCatalogAltUrl productCategoryId=productCategoryId/>"><h3 class="panel-title">${productCategory.categoryName!productCategoryId}</h3></a>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <table class="table">
                                    <tbody>
                                    <#if productCategoryMembers??>
                                        <#assign i = 0/>
                                        <#list productCategoryMembers as productCategoryMember>
                                            <#if (i > 2)>
                                                <#if productCategoryMembers[i]?has_content>
                                                    <tr>
                                                    <td>
                                                    <a class="linktext" href="<@ofbizCatalogAltUrl productCategoryId=productCategoryId/>">
                                                        <span>More...</span>
                                                    </a>
                                                    </td>
                                                    </tr>
                                                </#if>
                                                <#break>
                                            </#if>
                                            <#if productCategoryMember?has_content>
                                                <#assign product = delegator.findOne("Product", Static["org.ofbiz.base.util.UtilMisc"].toMap("productId", productCategoryMember.productId), false)>
                                                <tr>
                                                    <td>
                                                        <li class="browsecategorytext">
                                                            <a class="linktext" href="<@ofbizCatalogAltUrl productCategoryId="PROMOTIONS" productId="${product.productId}"/>">
                                                                ${product.productName!product.productId}
                                                            </a>
                                                        </li>
                                                    </td>
                                                </tr>
                                            </#if>
                                            <#assign i = i+1/>
                                        </#list>
                                    </#if>
                                    </tbody>
                                    </table>
                                </div>
                            </div>
                        </td>
                        <#assign cateCount = cateCount + 1/>
                    </#list>
                <tr/>
            </#list>
            </tbody>
            </table>
            </div>
        </div>
    </div>
</#if>
