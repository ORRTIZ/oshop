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
<div class="product-tags">
    <p class="titleProductTags"><h3>${uiLabelMap.EcommerceProductTags}</h3></p>
    <#if productTags??>
        <p class="titleAddTags"><strong>${uiLabelMap.EcommerceProductTagsDetail}:</strong></p>
        <p>
            <ul>
                <li>
                <#assign no = 0 />
                <#list productTags?keys?sort as productTag>
                    <#assign tagValue = productTags.get(productTag)!/>
                    <#if tagValue?has_content>
                          <span><a href="javascript:void(0);" id="productTag_${productTag}">${productTag}</a> (${tagValue}) <#if no < (productTags.size() - 1)> | </#if></span>
                          <#assign no = no + 1 />
                    </#if>
                </#list>
                </li>
            </ul>
        </p>
    </#if>
        
    <p class="titleAddTags"><strong>${uiLabelMap.EcommerceAddYourTags}:</strong></p>
    <p>
        <form method="post" action="<@ofbizUrl>addProductTags</@ofbizUrl>" name="addProductTags">
            <input type="hidden" name="productId" value="${product.productId!}"/>
            <input class="inputProductTags" type="text" value="" name="productTags" id="productTags" size="40"/>
            <input class="buttonProductTags" type="submit" value="${uiLabelMap.EcommerceAddTags}" name="addTag"/>
        </form>
        <span>${uiLabelMap.EcommerceAddTagsDetail}</span>
    </p>
    <hr />
    <form action="<@ofbizUrl>tagsearch</@ofbizUrl>" method="post" name="productTagsearchform" id="productTagsearchform">
        <input type="hidden" name="keywordTypeId" value="KWT_TAG"/>
        <input type="hidden" name="statusId" value="KW_APPROVED"/>
        <input type="hidden" name="clearSearch" value="Y"/>
        <input type="hidden" name="VIEW_SIZE" value="10"/>
        <input type="hidden" name="PAGING" value="Y"/>
        <input type="hidden" name="SEARCH_STRING" id="productTagStr"/>
    </form>
</div>