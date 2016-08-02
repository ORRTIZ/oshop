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
<#-- Upgrades/Up-Sell/Cross-Sell -->
<#macro associated assocProducts beforeName showName afterName formNamePrefix targetRequestName>
    <#assign pageProduct = product />
    <#assign targetRequest = "product" />
    <#if targetRequestName?has_content>
        <#assign targetRequest = targetRequestName />
    </#if>
    <#if assocProducts?has_content>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">${beforeName!}<#if showName == "Y">${productContentWrapper.get("PRODUCT_NAME", "html")!}</#if>${afterName!}</h3>
            </div>
            <div class="panel-body">
                <div class="productsummary-container">
                    <#list assocProducts as productAssoc>
                        <#if productAssoc.productId == product.productId>
                            <#assign assocProductId = productAssoc.productIdTo />
                        <#else>
                            <#assign assocProductId = productAssoc.productId />
                        </#if>
                        <div>
                            <a href="<@ofbizUrl>${targetRequest}/<#if categoryId??>~category_id=${categoryId}/</#if>~product_id=${assocProductId}</@ofbizUrl>" class="buttontext">
                                ${assocProductId}
                            </a><br/>
                            <#if productAssoc.reason?has_content> - <strong>${productAssoc.reason}</strong></#if>
                        </div>
                        ${setRequestAttribute("optProductId", assocProductId)}
                        ${setRequestAttribute("listIndex", listIndex)}
                        ${setRequestAttribute("formNamePrefix", formNamePrefix)}
                        <#if targetRequestName?has_content>
                            ${setRequestAttribute("targetRequestName", targetRequestName)}
                        </#if>
                        ${screens.render(productsummaryScreen)}
                        <#assign product = pageProduct />
                        <#local listIndex = listIndex + 1 />
                    </#list>
                </div>
            </div>
        </div>

        ${setRequestAttribute("optProductId", "")}
        ${setRequestAttribute("formNamePrefix", "")}
        ${setRequestAttribute("targetRequestName", "")}
    </#if>
</#macro>

<#assign productValue = product />
<#assign listIndex = 1 />
${setRequestAttribute("productValue", productValue)}
<div id="associated-products">
    <#-- also bought -->
    <@associated assocProducts=alsoBoughtProducts beforeName="" showName="N" afterName="${uiLabelMap.ProductAlsoBought}" formNamePrefix="albt" targetRequestName="" />
    <#-- obsolete -->
    <@associated assocProducts=obsoleteProducts beforeName="" showName="Y" afterName=" ${uiLabelMap.ProductObsolete}" formNamePrefix="obs" targetRequestName="" />
    
    <#-- cross sell -->
    <@associated assocProducts=crossSellProducts beforeName="" showName="N" afterName="${uiLabelMap.ProductCrossSell}" formNamePrefix="cssl" targetRequestName="crosssell" />
    
    <#-- up sell -->
    <@associated assocProducts=upSellProducts beforeName="${uiLabelMap.ProductUpSell} " showName="Y" afterName=":" formNamePrefix="upsl" targetRequestName="upsell" />
    
    <#-- obsolescence -->
    <@associated assocProducts=obsolenscenseProducts beforeName="" showName="Y" afterName=" ${uiLabelMap.ProductObsolescense}" formNamePrefix="obce" targetRequestName="" />
</div>

<#-- special cross/up-sell area using commonFeatureResultIds (from common feature product search) -->
<#if commonFeatureResultIds?has_content>
    <h2>${uiLabelMap.ProductSimilarProducts}</h2>
    <div class="productsummary-container">
        <#list commonFeatureResultIds as commonFeatureResultId>
            ${setRequestAttribute("optProductId", commonFeatureResultId)}
            ${setRequestAttribute("listIndex", commonFeatureResultId_index)}
            ${setRequestAttribute("formNamePrefix", "cfeatcssl")}
            <#--  ${setRequestAttribute("targetRequestName", targetRequestName)} -->
            ${screens.render(productsummaryScreen)}
        </#list>
    </div>
</#if>