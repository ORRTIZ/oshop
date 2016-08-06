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
<#-- variable setup -->
<#assign price = priceMap! />
<#assign productImageList = productImageList! />
<#-- end variable setup -->

<#-- virtual product javascript -->
${virtualJavaScript!}
${virtualVariantJavaScript!}
<script type="text/javascript">
//<![CDATA[
var detailImageUrl = null;
function setAddProductId(name) {
    document.addform.add_product_id.value = name;
    if (document.addform.quantity == null) return;
    if (name == '' || name == 'NULL' || isVirtual(name) == true) {
        document.addform.quantity.disabled = true;
        var elem = document.getElementById('product_id_display');
        var txt = document.createTextNode('');
        if(elem.hasChildNodes()) {
            elem.replaceChild(txt, elem.firstChild);
        } else {
            elem.appendChild(txt);
        }
    } else {
        document.addform.quantity.disabled = false;
        var elem = document.getElementById('product_id_display');
        var txt = document.createTextNode(name);
        if(elem.hasChildNodes()) {
            elem.replaceChild(txt, elem.firstChild);
        } else {
            elem.appendChild(txt);
        }
    }
}

function setVariantPrice(sku) {
    if (sku == '' || sku == 'NULL' || isVirtual(sku) == true) {
        var elem = document.getElementById('variant_price_display');
        var txt = document.createTextNode('');
        if(elem.hasChildNodes()) {
            elem.replaceChild(txt, elem.firstChild);
        } else {
            elem.appendChild(txt);
        }
    }
    else {
        var elem = document.getElementById('variant_price_display');
        var price = getVariantPrice(sku);
        var txt = document.createTextNode(price);
        if(elem.hasChildNodes()) {
            elem.replaceChild(txt, elem.firstChild);
        } else {
            elem.appendChild(txt);
        }
    }
}

function isVirtual(product) {
    var isVirtual = false;
    <#if virtualJavaScript??>
        for (i = 0; i < VIR.length; i++) {
            if (VIR[i] == product) {
                isVirtual = true;
            }
        }
    </#if>
    return isVirtual;
}

function addItem() {
   if (document.addform.add_product_id.value == 'NULL') {
       showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.CommonPleaseSelectAllRequiredOptions}");
       return;
   } else {
       if (isVirtual(document.addform.add_product_id.value)) {
           document.location = '<@ofbizUrl>product?category_id=${categoryId!}&amp;product_id=</@ofbizUrl>' + document.addform.add_product_id.value;
           return;
       } else {
           document.addform.submit();
       }
   }
}

function popupDetail(specificDetailImageUrl) {
    if( specificDetailImageUrl ) {
        detailImageUrl = specificDetailImageUrl;
    }
    else {
        var defaultDetailImage = "${firstDetailImage?default(mainDetailImageUrl?default("_NONE_"))}";
        if (defaultDetailImage == null || defaultDetailImage == "null" || defaultDetailImage == "") {
           defaultDetailImage = "_NONE_";
        }
        if (detailImageUrl == null || detailImageUrl == "null") {
            detailImageUrl = defaultDetailImage;
        }
    }
    if (detailImageUrl == "_NONE_") {
        hack = document.createElement('span');
        hack.innerHTML="${uiLabelMap.CommonNoDetailImageAvailableToDisplay}";
        showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.CommonNoDetailImageAvailableToDisplay}");
        return;
    }
    detailImageUrl = detailImageUrl.replace(/\&\#47;/g, "/");
    popUp("<@ofbizUrl>detailImage?detail=" + detailImageUrl + "</@ofbizUrl>", 'detailImage', '600', '600');
}

function toggleAmt(toggle) {
    if (toggle == 'Y') {
        changeObjectVisibility("add_amount", "visible");
    }
    if (toggle == 'N') {
        changeObjectVisibility("add_amount", "hidden");
    }
}

function findIndex(name) {
    for (i = 0; i < OPT.length; i++) {
        if (OPT[i] == name) {
            return i;
        }
    }
    return -1;
}

function getList(name, index, src) {
    currentFeatureIndex = findIndex(name);
    if (currentFeatureIndex == 0) {
        // set the images for the first selection
        if (IMG[index] != null) {
            if (document.images['mainImage'] != null) {
                document.images['mainImage'].src = IMG[index];
                detailImageUrl = DET[index];
            }
        }
        // set the drop down index for swatch selection
        document.forms["addform"].elements[name].selectedIndex = (index*1)+1;
    }
    if (currentFeatureIndex < (OPT.length-1)) {
        // eval the next list if there are more
        var selectedValue = document.forms["addform"].elements[name].options[(index*1)+1].value;
        if (index == -1) {
        <#if featureOrderFirst??>
            var Variable1 = eval("list" + "${featureOrderFirst}" + "()");
        </#if>
    } else {
        var Variable1 = eval("list" + OPT[(currentFeatureIndex+1)] + selectedValue + "()");
    }
    // set the product ID to NULL to trigger the alerts
    setAddProductId('NULL');
    // set the variant price to NULL
    setVariantPrice('NULL');
    } else {
        // this is the final selection -- locate the selected index of the last selection
        var indexSelected = document.forms["addform"].elements[name].selectedIndex;
        // using the selected index locate the sku
        var sku = document.forms["addform"].elements[name].options[indexSelected].value;
        // display alternative packaging dropdown
        ajaxUpdateArea("product_uom", "<@ofbizUrl>ProductUomDropDownOnly</@ofbizUrl>", "productId=" + sku);
        // set the product ID
        setAddProductId(sku);
        // set the variant price
        setVariantPrice(sku);
        // check for amount box
        toggleAmt(checkAmtReq(sku));
    }
}

function validate(x){
    var msg=new Array();
    msg[0]="Please use correct date format [yyyy-mm-dd]";
    var y=x.split("-");
    if(y.length!=3){ showAlert(msg[0]);return false; }
    if((y[2].length>2)||(parseInt(y[2])>31)) { showAlert(msg[0]); return false; }
    if(y[2].length==1){ y[2]="0"+y[2]; }
    if((y[1].length>2)||(parseInt(y[1])>12)){ showAlert(msg[0]); return false; }
    if(y[1].length==1){ y[1]="0"+y[1]; }
    if(y[0].length>4){ showAlert(msg[0]); return false; }
    if(y[0].length<4) {
        if(y[0].length==2) {
            y[0]="20"+y[0];
        } else {
            showAlert(msg[0]);
            return false;
        }
    }
    return (y[0]+"-"+y[1]+"-"+y[2]);
}

function showAlert(msg){
    showErrorAlert("${uiLabelMap.CommonErrorMessage2}", msg);
}

function additemSubmit(){
    <#if product.productTypeId! == "ASSET_USAGE" || product.productTypeId! == "ASSET_USAGE_OUT_IN">
        newdatevalue = validate(document.addform.reservStart.value);
        if (newdatevalue == false) {
            document.addform.reservStart.focus();
        } else {
            document.addform.reservStart.value = newdatevalue;
            document.addform.submit();
        }
    <#else>
        document.addform.submit();
    </#if>
}

function addShoplistSubmit(){
    <#if product.productTypeId! == "ASSET_USAGE" || product.productTypeId! == "ASSET_USAGE_OUT_IN">
        if (document.addToShoppingList.reservStartStr.value == "") {
            document.addToShoppingList.submit();
        } else {
            newdatevalue = validate(document.addToShoppingList.reservStartStr.value);
            if (newdatevalue == false) {
                document.addToShoppingList.reservStartStr.focus();
            } else {
                document.addToShoppingList.reservStartStr.value = newdatevalue;
                // document.addToShoppingList.reservStart.value = ;
                document.addToShoppingList.reservStartStr.value.slice(0,9)+" 00:00:00.000000000";
                document.addToShoppingList.submit();
            }
        }
    <#else>
        document.addToShoppingList.submit();
    </#if>
}

    <#if product.virtualVariantMethodEnum! == "VV_FEATURETREE" && featureLists?has_content>
        function checkRadioButton() {
            var block1 = document.getElementById("addCart1");
            var block2 = document.getElementById("addCart2");
            <#list featureLists as featureList>
                <#list featureList as feature>
                    <#if feature_index == 0>
                        var myList = document.getElementById("FT${feature.productFeatureTypeId}");
                         if (myList.options[0].selected == true){
                             block1.style.display = "none";
                             block2.style.display = "block";
                             return;
                         }
                        <#break>
                    </#if>
                </#list>
            </#list>
            block1.style.display = "block";
            block2.style.display = "none";
        }
    </#if>
    
function displayProductVirtualVariantId(variantId) {
    if(variantId){
        document.addform.product_id.value = variantId;
    }else{
        document.addform.product_id.value = '';
        variantId = '';
    }
    var elem = document.getElementById('product_id_display');
    var txt = document.createTextNode(variantId);
    if(elem.hasChildNodes()) {
        elem.replaceChild(txt, elem.firstChild);
    } else {
        elem.appendChild(txt);
    }
    var priceElem = document.getElementById('variant_price_display');
    var price = getVariantPrice(variantId);
    var priceTxt = null;
    if(price){
        priceTxt = document.createTextNode(price);
    }else{
        priceTxt = document.createTextNode('');
    }
    if(priceElem.hasChildNodes()) {
        priceElem.replaceChild(priceTxt, priceElem.firstChild);
    } else {
        priceElem.appendChild(priceTxt);
    }
}
//]]>

$(function(){
    $('a[id^=productTag_]').click(function(){
        var id = $(this).attr('id');
        var ids = id.split('_');
        var productTagStr = ids[1];
        if (productTagStr) {
            $('#productTagStr').val(productTagStr);
            $('#productTagsearchform').submit();
        }
    });
})
 </script>

<#macro showUnavailableVarients>
    <#if unavailableVariants??>
        <ul>
            <#list unavailableVariants as prod>
                <#assign features = prod.getRelated("ProductFeatureAppl", null, null, false)/>
                <li>
                    <#list features as feature>
                        <em>${feature.getRelatedOne("ProductFeature", false).description}</em><#if feature_has_next>, </#if>
                    </#list>
                    <span>${uiLabelMap.ProductItemOutOfStock}</span>
                </li>
            </#list>
        </ul>
    </#if>
</#macro>

<div id="ProductPrevNext" class="row">
    <div class="col-md-12">
        <#-- Category next/previous -->
        <#if category??>
            <nav>
                <ul class="pager">
                    <#if previousProductId??>
                        <li class="previous"><a href="<@ofbizCatalogAltUrl productCategoryId=categoryId! productId=previousProductId!/>" class="btn btn-default btn-sm">${uiLabelMap.CommonPrevious}</a></li>
                    </#if>
                    <a href="<@ofbizCatalogAltUrl productCategoryId=categoryId!/>" class="linktext">${(category.categoryName)?default(category.description)!}</a>
                    <#if nextProductId??>
                        <li class="next"><a href="<@ofbizCatalogAltUrl productCategoryId=categoryId! productId=nextProductId!/>" class="btn btn-default btn-sm">${uiLabelMap.CommonNext}</a></li>
                    </#if>
                </ul>
            </nav>
        </#if>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">
            <#if product.brandName??>${product.brandName} - </#if>${productContentWrapper.get("PRODUCT_NAME", "html")!}
        </h3>
    </div>
    <div class="panel-body">
        <div class="row" id="productdetail">
            <div class="col-md-6">
                <#include "ProductImage.ftl" />
            </div>
            <div class="col-md-6">
                <#include "ProductMetaData.ftl" />
                <#include "ProductPrice.ftl" />
                <#include "ProductAddToOrder.ftl" />
                <#include "ProductPieces.ftl" />
                <#include "ProductSwatches.ftl"/><!-- product swatches -->
                <#include "ProductTellaFriend.ftl" />
                <#include "ProductAddToShopList.ftl" /><!-- product add to shop list -->
            </div>
        </div>
        <div id="productDescriptionBox" class="row">
            <div class="col-md-12">
                <ul class="nav nav-tabs">
                    <li class="active"><a data-toggle="tab" href="#ProductDescription">Description</a></li>
                    <li><a data-toggle="tab" href="#ProductDimensions">Dimensions</a></li>
                    <li><a data-toggle="tab" href="#ProductTags">Tags</a></li>
                    <li><a data-toggle="tab" href="#ProductReviews">Reviews</a></li>
                </ul>
                <div class="tab-content">
                    <div id="ProductDescription" class="tab-pane fade in active">
                        <#include "ProductLongDescription.ftl" /><!-- product long description -->
                        <#include "ProductDigitalDownload.ftl" /><!-- product digital downloads -->
                    </div>
                    <div id="ProductDimensions" class="tab-pane fade">
                        <#include "ProductDimensions.ftl" /><!-- product dimensions -->
                    </div>
                    <div id="ProductTags" class="tab-pane fade">
                        <#include "ProductTags.ftl" /><!-- product tags -->
                    </div>
                    <div id="ProductReviews" class="tab-pane fade">
                        <#include "ProductReviews.ftl" /><!-- product reviews -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



<div id="productCrossSell" class="row">
    <div class="col-md-12">
        <#include "ProductCrossSell.ftl" /><!-- product cross sell -->
    </div>
</div>
</div>