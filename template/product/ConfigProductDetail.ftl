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
<#assign productContentWrapper = productContentWrapper!>
<#assign price = priceMap!>
<#-- end variable setup -->

<#-- virtual product javascript -->
${virtualJavaScript!}
<script language="JavaScript" type="text/javascript">
<!--
var detailImageUrl = null;
function setAddProductId(name) {
    document.addform.add_product_id.value = name;
        if (document.addform.quantity == null) return;
        if (name == 'NULL' || isVirtual(name) == true) {
            document.addform.quantity.disabled = true;
        } else {
            document.addform.quantity.disabled = false;
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
    document.configform.action = document.addform.action;
    document.configform.quantity.value = document.addform.quantity.value;
    document.configform.submit();
}

function verifyConfig() {
    document.configform.submit();
}

function popupDetail() {
    var defaultDetailImage = "${firstDetailImage?default(mainDetailImageUrl?default("_NONE_"))}";
    if (defaultDetailImage == null || defaultDetailImage == "null" || defaultDetailImage == "") {
        defaultDetailImage = "_NONE_";
    }

    if (detailImageUrl == null || detailImageUrl == "null") {
        detailImageUrl = defaultDetailImage;
    }

    if (detailImageUrl == "_NONE_") {
        hack = document.createElement('span');
        hack.innerHTML="${uiLabelMap.CommonNoDetailImageAvailableToDisplay}";
        showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.CommonNoDetailImageAvailableToDisplay}");
        return;
    }
    detailImageUrl = detailImageUrl.replace(/\&\#47;/g, "/");
    popUp("<@ofbizUrl>detailImage?detail=" + detailImageUrl + "</@ofbizUrl>", 'detailImage', '400', '550');
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
        eval("list" + OPT[(currentFeatureIndex+1)] + selectedValue + "()");

        // set the product ID to NULL to trigger the alerts
        setAddProductId('NULL');
    } else {
        // this is the final selection -- locate the selected index of the last selection
        var indexSelected = document.forms["addform"].elements[name].selectedIndex;

        // using the selected index locate the sku
        var sku = document.forms["addform"].elements[name].options[indexSelected].value;

        // set the product ID
        setAddProductId(sku);

        // check for amount box
        toggleAmt(checkAmtReq(sku));
    }
}
 //-->
 </script>

<script language="JavaScript" type="text/javascript">
<!--

jQuery(document).ready(function () {
    jQuery('#configFormId').change(getConfigDetails)
});

function getConfigDetails(event) {
    jQuery.ajax({
        url: '<@ofbizUrl>getConfigDetailsEvent</@ofbizUrl>',
        type: 'POST',
        data: jQuery('#configFormId').serialize(),
        success: function(data) {
            var totalPrice = data.totalPrice;
            var configId = data.configId;
            document.getElementById('totalPrice').innerHTML = totalPrice;
            document.addToShoppingList.configId.value = configId;
            event.stop();
        }
    });
}

-->
</script>

<div id="ProductPrevNext" class="row">
    <div class="col-md-12">
        <#-- Category next/previous -->
        <#if category??>
            <div id="paginationBox">
                <#if previousProductId??>
                    <a href="<@ofbizCatalogAltUrl productCategoryId=categoryId! productId=previousProductId!/>" class="buttontext">${uiLabelMap.CommonPrevious}</a>&nbsp;|&nbsp;
                </#if>
                <a href="<@ofbizCatalogAltUrl productCategoryId=categoryId!/>" class="linktext">${(category.categoryName)?default(category.description)!}</a>
                <#if nextProductId??>
                    &nbsp;|&nbsp;<a href="<@ofbizCatalogAltUrl productCategoryId=categoryId! productId=nextProductId!/>" class="buttontext">${uiLabelMap.CommonNext}</a>
                </#if>
            </div>
        </#if>
    </div>
</div>

<div id="productdetail" class="row">
    <div class="col-md-6">
        <#include "ProductImage.ftl" />
    </div>
    <div class="col-md-6">
        <#include "ProductMetaData.ftl" />
        <#include "ProductConfigurator.ftl" />
        <#include "ProductPieces.ftl" />
        <#include "ProductSwatches.ftl"/><!-- product swatches -->
        <#include "ProductTellaFriend.ftl" />
        <#include "ProductAddToShopList.ftl" /><!-- product add to shop list -->
    </div>
</div>

<div id="productDetailBox" class="row">
    <div class="col-md-12">
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#home">Description</a></li>
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

<div id="productCrossSell" class="row">
    <div class="col-md-12">
        <#include "ProductCrossSell.ftl" /><!-- product cross sell -->
    </div>
</div>
