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
<div id="addItemForm">
    <form method="post" action="<@ofbizUrl>additem</@ofbizUrl>" name="addform" style="margin: 0;">
        <fieldset>
            ${productStoreId}
            <#assign inStock = true />
            <#--
            <#assign commentEnable = Static["org.ofbiz.entity.util.EntityUtilProperties"].getPropertyValue("order", "order.item.comment.enable", delegator)>
            <#if commentEnable.equals("Y")>
                <#assign orderItemAttr = Static["org.ofbiz.entity.util.EntityUtilProperties"].getPropertyValue("order", "order.item.attr.prefix", delegator)>
                ${uiLabelMap.CommonComment}&nbsp;<input type="text" name="${orderItemAttr}comment"/>
            </#if>
            -->
            <#-- Variant Selection -->
            <#if product.isVirtual!?upper_case == "Y">
                <#if product.virtualVariantMethodEnum! == "VV_FEATURETREE" && featureLists?has_content>
                    <#list featureLists as featureList>
                        <#list featureList as feature>
                            <#if feature_index == 0>
                                <div>
                                    ${feature.description}: 
                                    <select id="FT${feature.productFeatureTypeId}" name="FT${feature.productFeatureTypeId}" onchange="javascript:checkRadioButton();">
                                        <option value="select" selected="selected">${uiLabelMap.EcommerceSelectOption}</option>
                            <#else>
                                <option value="${feature.productFeatureId}">${feature.description} <#if feature.price??>(+ <@ofbizCurrency amount=feature.price?string isoCode=feature.currencyUomId />)</#if></option>
                            </#if>
                        </#list>
                    </select>
                </div>
            </#list>
            <input type="hidden" name="add_product_id" value="${product.productId}" />
            <div id="addCart1" style="display:none;">
                <span style="white-space: nowrap;"><strong>${uiLabelMap.CommonQuantity}:</strong></span>&nbsp;
                <input type="hidden" size="5" name="quantity" value="1" />
                <a href="javascript:javascript:addItem();" class="btn btn-success btn-sm"><span style="white-space: nowrap;">${uiLabelMap.OrderAddToCart}</span></a>
                &nbsp;
            </div>
            <div id="addCart2" style="display:block;">
                <span style="white-space: nowrap;"><strong>${uiLabelMap.CommonQuantity}:</strong></span>&nbsp;
                <input type="text" size="5" value="1" disabled="disabled" />
                <a href="javascript:showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.CommonPleaseSelectAllFeaturesFirst}");" class="btn btn-ssuccess btn-sm"><span style="white-space: nowrap;">${uiLabelMap.OrderAddToCart}</span></a>
                &nbsp;
            </div>
        </#if>
        <#if !product.virtualVariantMethodEnum?? || product.virtualVariantMethodEnum == "VV_VARIANTTREE">
            <#if variantTree?? && (variantTree.size() &gt; 0)>
                <#list featureSet as currentType>
                    <div>
                        <select name="FT${currentType}" onchange="javascript:getList(this.name, (this.selectedIndex-1), 1);">
                            <option>${featureTypes.get(currentType)}</option>
                        </select>
                    </div>
                </#list>
                <span id="product_uom"></span>
                <input type="hidden" name="product_id" value="${product.productId}"/>
                <input type="hidden" name="add_product_id" value="NULL"/>
                <div>
                    <strong><span id="product_id_display"> </span></strong>
                    <strong><div id="variant_price_display"> </div></strong>
                </div>
            <#else>
                <input type="hidden" name="add_product_id" value="NULL"/>
                <#assign inStock = false />
            </#if>
        </#if>
    <#else>
        <input type="hidden" name="add_product_id" value="${product.productId}" />
        <#if mainProducts?has_content>
            <input type="hidden" name="product_id" value=""/>
            <select name="productVariantId" onchange="javascript:displayProductVirtualVariantId(this.value);">
                <option value="">Select Unit Of Measure</option>
                <#list mainProducts as mainProduct>
                    <option value="${mainProduct.productId}">${mainProduct.uomDesc} : ${mainProduct.piecesIncluded}</option>
                </#list>
            </select><br/>
            <div>
                <strong><span id="product_id_display"> </span></strong>
                <strong><div id="variant_price_display"> </div></strong>
            </div>
        </#if>
            <#if (availableInventory??) && (availableInventory <= 0) && product.requireAmount?default("N") == "N">
                <#assign inStock = false />
            </#if>
        </#if>

        <#-- check to see if introductionDate hasnt passed yet -->
        <#if product.introductionDate?? && nowTimestamp.before(product.introductionDate)>
            <p>&nbsp;</p>
            <div style="color: red;">${uiLabelMap.ProductProductNotYetMadeAvailable}.</div>

            <#-- check to see if salesDiscontinuationDate has passed -->
            <#elseif product.salesDiscontinuationDate?? && nowTimestamp.after(product.salesDiscontinuationDate)>
                <div style="color: red;">${uiLabelMap.ProductProductNoLongerAvailable}.</div>
            
            <#-- check to see if the product requires inventory check and has inventory -->
            <#elseif product.virtualVariantMethodEnum! != "VV_FEATURETREE">
                <#if inStock>
                    <#if product.requireAmount?default("N") == "Y">
                        <#assign hiddenStyle = "visible" />
                    <#else>
                        <#assign hiddenStyle = "hidden"/>
                    </#if>
                    <div id="add_amount" class="${hiddenStyle}">
                        <span style="white-space: nowrap;"><strong>${uiLabelMap.CommonAmount}:</strong></span>&nbsp;
                        <input type="text" size="5" name="add_amount" value=""/>
                    </div>
                    <#if product.productTypeId! == "ASSET_USAGE" || product.productTypeId! == "ASSET_USAGE_OUT_IN">
                        <div>
                            <label>Start Date(yyyy-mm-dd)</label><@htmlTemplate.renderDateTimeField event="" action="" name="reservStart" className="" alert="" title="Format: yyyy-MM-dd HH:mm:ss.SSS" value="${startDate}" size="25" maxlength="30" id="reservStart1" dateType="date" shortDateInput=true timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
                        </div>
                        <div>
                            <#--td nowrap="nowrap" align="right">Number<br />of days</td><td><input type="textt" size="4" name="reservLength"/></td></tr><tr><td>&nbsp;</td><td align="right" nowrap="nowrap">&nbsp;</td-->
                            Number of days<input type="text" size="4" name="reservLength" value=""/>
                            Number of persons<input type="text" size="4" name="reservPersons" value="2"/>
                            Number of rooms<input type="text" size="5" name="quantity" value="1"/>
                        </div>
                        <br/>
                        <a href="javascript:addItem()" class="btn btn-warning btn-sm">
                            <span style="white-space: nowrap;">${uiLabelMap.OrderAddToCart}</span>
                        </a>
                    <#else>
                        <span><input name="quantity" id="quantity" value="1" size="4" maxLength="4" type="text" <#if product.isVirtual!?upper_case == "Y">disabled="disabled"</#if> /></span>
                        <a href="javascript:addItem()" id="addToCart" name="addToCart" class="btn btn-warning btn-sm">${uiLabelMap.OrderAddToCart}</a>
                        <br/><br/>
                        <@showUnavailableVarients/>
                    </#if>
                <#else>
                    <#if productStore??>
                        <#if productStore.requireInventory?? && productStore.requireInventory == "N">
                            <span>
                                <input name="quantity" id="quantity" value="1" size="4" maxLength="4" type="text" <#if product.isVirtual!?upper_case == "Y">disabled="disabled"</#if> />
                            </span>
                            <a href="javascript:addItem()" id="addToCart" name="addToCart" class="btn btn-success btn-sm">${uiLabelMap.OrderAddToCart}</a>
                            <@showUnavailableVarients/>
                        <#else>
                            <span><input name="quantity" id="quantity" value="1" size="4" maxLength="4" type="text" disabled="disabled" /></span>
                            <a href="javascript:void(0);" disabled="disabled" class="btn btn-warning btn-sm">${uiLabelMap.OrderAddToCart}</a><br />
                            <span>${uiLabelMap.ProductItemOutOfStock}<#if product.inventoryMessage??>&mdash; ${product.inventoryMessage}</#if></span>
                        </#if>
                    </#if>
                </#if>
            </#if>

            <#if variantPriceList??>
                <#list variantPriceList as vpricing>
                    <#assign variantName = vpricing.get("variantName")!>
                    <#assign secondVariantName = vpricing.get("secondVariantName")!>
                    <#assign minimumQuantity = vpricing.get("minimumQuantity")>
                    <#if minimumQuantity &gt; 0>
                        <div>minimum order quantity for ${secondVariantName!} ${variantName!} is ${minimumQuantity!}</div>
                    </#if>
                </#list>
            <#elseif minimumQuantity?? && minimumQuantity?has_content && minimumQuantity &gt; 0>
                <div>minimum order quantity for ${productContentWrapper.get("PRODUCT_NAME", "html")!} is ${minimumQuantity!}</div>
            </#if>
        </fieldset>
    </form>
</div>



<#-- Prefill first select box (virtual products only) -->
<#if variantTree?? && 0 &lt; variantTree.size()>
    <script type="text/javascript">eval("list" + "${featureOrderFirst}" + "()");</script>
</#if>
