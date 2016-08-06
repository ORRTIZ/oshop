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
<#-- Swatches (virtual products only) -->
<#if variantSample?? && 0 &lt; variantSample.size()>
    <#assign imageKeys = variantSample.keySet() />
    <#assign imageMap = variantSample />
    <p>&nbsp;</p>
    <#assign maxIndex = 7 />
    <#assign indexer = 0 />
    <#list imageKeys as key>
        <#assign swatchProduct = imageMap.get(key) />
        <#if swatchProduct?has_content && indexer &lt; maxIndex>
            <#assign imageUrl = Static["org.ofbiz.product.product.ProductContentWrapper"].getProductContentAsText(swatchProduct, "MEDIUM_IMAGE_URL", request, "url")! />
            <#if !imageUrl?string?has_content>
                <#assign imageUrl = productContentWrapper.get("MEDIUM_IMAGE_URL", "url")! />
            </#if>
            <#if !imageUrl?string?has_content>
                <#assign imageUrl = "/images/defaultImage.jpg" />
            </#if>
            <a href="javascript:getList('FT${featureOrderFirst}','${indexer}',1);" class="linktext">${key}</a>
            <a href="javascript:getList('FT${featureOrderFirst}','${indexer}',1);"><img src="<@ofbizContentUrl>${contentPathPrefix!}${imageUrl}</@ofbizContentUrl>" class="cssImgSmall" alt="" /></a>
            <br />
        </#if>
        <#assign indexer = indexer + 1 />
    </#list>
    <#if (indexer > maxIndex)>
        <div><strong>${uiLabelMap.ProductMoreOptions}</strong></div>
    </#if>
</#if>

