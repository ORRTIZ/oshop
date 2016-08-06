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
<#assign productAdditionalImage1 = productContentWrapper.get("ADDITIONAL_IMAGE_1", "url")! />
<#assign productAdditionalImage2 = productContentWrapper.get("ADDITIONAL_IMAGE_2", "url")! />
<#assign productAdditionalImage3 = productContentWrapper.get("ADDITIONAL_IMAGE_3", "url")! />
<#assign productAdditionalImage4 = productContentWrapper.get("ADDITIONAL_IMAGE_4", "url")! />
<div id="productImageBox">
    <#if productImageList?has_content>
        <div id="detailImageBox" class="slides_container" style="overflow: hidden; position: relative; display: block;">
            <#-- Product image/name/price -->
            <#assign productLargeImageUrl = productContentWrapper.get("LARGE_IMAGE_URL", "url")! />
            <#-- remove the next two lines to always display the virtual image first (virtual images must exist) -->
            <#if firstLargeImage?has_content>
                <#assign productLargeImageUrl = firstLargeImage />
            </#if>
            <#if productLargeImageUrl?string?has_content>
                <a href="javascript:popupDetail();"><img id="detailImage" src="<@ofbizContentUrl>${contentPathPrefix!}${productLargeImageUrl!}</@ofbizContentUrl>" name="mainImage" vspace="5" hspace="5" class="cssImgXLarge" alt="" /></a>
                <input type="hidden" id="originalImage" name="originalImage" value="<@ofbizContentUrl>${contentPathPrefix!}${productLargeImageUrl!}</@ofbizContentUrl>" />
            </#if>
            <#if !productLargeImageUrl?string?has_content>
                <img id="detailImage" src="/images/defaultImage.jpg" name="mainImage" alt="" />
            </#if>
            <a class="prev" href="#">Prev</a>
            <a class="next" href="#">Next</a>
            <#if productImageList?has_content>
                <ul class="pagination">
                <#list productImageList as productImage>
                    <li class="">
                        <a href="javascript:void(0);" swapDetail="<@ofbizContentUrl>${productImage.productImage}</@ofbizContentUrl>">
                            <img src="<@ofbizContentUrl>${productImage.productImageThumb}</@ofbizContentUrl>" width="55px" height="41px" alt="" />
                        </a>
                    </li>
                </#list>
                </ul>
            </#if>
        </div>
        <div id="additionalImageBox">
            <#-- Show Image Approved -->
        </div>
        
    <#else>
        <div id="detailImageBox">
            <#-- Product image/name/price -->
            <#assign productLargeImageUrl = productContentWrapper.get("LARGE_IMAGE_URL", "url")! />
            <#-- remove the next two lines to always display the virtual image first (virtual images must exist) -->
            <#if firstLargeImage?has_content>
                <#assign productLargeImageUrl = firstLargeImage />
            </#if>
            <#if productLargeImageUrl?string?has_content>
                <a href="javascript:popupDetail();"><img id="detailImage" src="<@ofbizContentUrl>${contentPathPrefix!}${productLargeImageUrl!}</@ofbizContentUrl>" name="mainImage" vspace="5" hspace="5" class="cssImgXLarge" alt="" /></a>
                    <input type="hidden" id="originalImage" name="originalImage" value="<@ofbizContentUrl>${contentPathPrefix!}${productLargeImageUrl!}</@ofbizContentUrl>" />
            </#if>
            <#if !productLargeImageUrl?string?has_content>
                <img id="detailImage" src="/images/defaultImage.jpg" name="mainImage" alt="" />
            </#if>
        </div>
        <div id="additionalImageBox">
            <#if productAdditionalImage1?string?has_content>
                <div class="additionalImage">
                    <a href="javascript:void(0);" swapDetail="<@ofbizContentUrl>${productAdditionalImage1}</@ofbizContentUrl>"><img src="<@ofbizContentUrl>${productAdditionalImage1}</@ofbizContentUrl>" vspace="5" hspace="5" class="cssImgXLarge" alt="" /></a>
                </div>
            </#if>
            <#if productAdditionalImage2?string?has_content>
                <div class="additionalImage">
                    <a href="javascript:void(0);" swapDetail="<@ofbizContentUrl>${productAdditionalImage2}</@ofbizContentUrl>"><img src="<@ofbizContentUrl>${productAdditionalImage2}</@ofbizContentUrl>" vspace="5" hspace="5" class="cssImgXLarge" alt="" /></a>
                </div>
            </#if>
            <#if productAdditionalImage3?string?has_content>
                <div class="additionalImage">
                    <a href="javascript:void(0);" swapDetail="<@ofbizContentUrl>${productAdditionalImage3}</@ofbizContentUrl>"><img src="<@ofbizContentUrl>${productAdditionalImage3}</@ofbizContentUrl>" vspace="5" hspace="5" class="cssImgXLarge" alt="" /></a>
                </div>
            </#if>
            <#if productAdditionalImage4?string?has_content>
                <div class="additionalImage">
                    <a href="javascript:void(0);" swapDetail="<@ofbizContentUrl>${productAdditionalImage4}</@ofbizContentUrl>"><img src="<@ofbizContentUrl>${productAdditionalImage4}</@ofbizContentUrl>" vspace="5" hspace="5" class="cssImgXLarge" alt="" /></a>
                </div>
            </#if>
        </div>
    </#if>
</div>