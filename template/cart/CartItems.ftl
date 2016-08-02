<div class="panel">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.ProductPromoCodes}</h3>
    </div>
    <div class="panel-body">
    <table class="items" width="100%">
    <thead>
        <tr>
            <th></th>
            <th scope="row">${uiLabelMap.OrderProduct}</th>
            <#if asslGiftWraps?has_content && productStore.showCheckoutGiftOptions! != "N">>
                <th scope="row">
                    <select class="selectBox" name="GWALL" onchange="javascript:gwAll(this);">
                        <option value="">${uiLabelMap.EcommerceGiftWrapAllItems}</option>
                        <option value="NO^">${uiLabelMap.EcommerceNoGiftWrap}</option>
                        <#list allgiftWraps as option>
                            <option value="${option.productFeatureId}">${option.description} : ${option.defaultAmount?default(0)}</option>
                        </#list>
                    </select>
            <#else>
                <th scope="row">&nbsp;</th>
            </#if>
            <#if fixedAssetExist == true>
                <td>
                    <table>
                        <tr>
                            <td>- ${uiLabelMap.EcommerceStartDate} -</td>
                            <td>- ${uiLabelMap.EcommerceNbrOfDays} -</td>
                        </tr>
                        <tr>
                            <td >- ${uiLabelMap.EcommerceNbrOfPersons} -</td>
                            <td >- ${uiLabelMap.CommonQuantity} -</td>
                        </tr>
                    </table>
                </td>
            <#else>
                <td scope="row" align="right"><strong>${uiLabelMap.CommonQuantity}</strong></td>
            </#if>
            <td scope="row" align="right"><strong>${uiLabelMap.EcommerceUnitPrice}</strong></td>
            <td scope="row" align="right"><strong>${uiLabelMap.EcommerceAdjustments}</strong></td>
            <td scope="row" align="right"><strong>${uiLabelMap.EcommerceItemTotal}</strong></td>
            <th scope="row"><input type="checkbox" name="selectAll" value="0" onclick="javascript:toggleAll(this);" /></th>
        </tr>
    </thead>
    <tbody>
        <#assign itemsFromList = false />
        <#assign promoItems = false />
        <#list shoppingCart.items() as cartLine>
            <#assign cartLineIndex = shoppingCart.getItemIndex(cartLine) />
            <#assign lineOptionalFeatures = cartLine.getOptionalProductFeatures() />
            <#-- show adjustment info -->
            <#list cartLine.getAdjustments() as cartLineAdjustment>
                <!-- cart line ${cartLineIndex} adjustment: ${cartLineAdjustment} -->
            </#list>
            <tr id="cartItemDisplayRow_${cartLineIndex}">
                <td align="right"
                    <#if cartLine.getShoppingListId()??>
                        <#assign itemsFromList = true />
                        <a href="<@ofbizUrl>editShoppingList?shoppingListId=${cartLine.getShoppingListId()}</@ofbizUrl>" class="linktext">L</a>&nbsp;&nbsp;
                    <#elseif cartLine.getIsPromo()>
                        <#assign promoItems = true />
                        <a href="<@ofbizUrl>showcart</@ofbizUrl>" class="button">P</a>&nbsp;&nbsp;
                    <#else>
                        &nbsp;
                    </#if>
                </td>
                <td>
                    <#if cartLine.getProductId()??>
                        <#-- product item -->
                        <#-- start code to display a small image of the product -->
                        <#if cartLine.getParentProductId()??>
                            <#assign parentProductId = cartLine.getParentProductId() />
                        <#else>
                            <#assign parentProductId = cartLine.getProductId() />
                        </#if>
                        <#assign smallImageUrl = Static["org.ofbiz.product.product.ProductContentWrapper"].getProductContentAsText(cartLine.getProduct(), "SMALL_IMAGE_URL", locale, dispatcher, "url")! />
                        <#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg" /></#if>
                        <#if smallImageUrl?string?has_content>
                            <a href="<@ofbizCatalogAltUrl productId=parentProductId/>">
                                <img src="<@ofbizContentUrl>${requestAttributes.contentPathPrefix!}${smallImageUrl}</@ofbizContentUrl>" alt="Product Image" class=".img-thumbnail" />
                            </a>
                        </#if>
                        <#-- end code to display a small image of the product -->
                        <#-- ${cartLineIndex} - -->
                        <a href="<@ofbizCatalogAltUrl productId=parentProductId/>" class="linktext">${cartLine.getProductId()} -
                            ${cartLine.getName()!}</a> : ${cartLine.getDescription()!}
                            <#-- For configurable products, the selected options are shown -->
                        <#if cartLine.getConfigWrapper()??>
                            <#assign selectedOptions = cartLine.getConfigWrapper().getSelectedOptions()! />
                            <#if selectedOptions??>
                                <div>&nbsp;</div>
                                <#list selectedOptions as option>
                                    <div>${option.getDescription()}</div>
                                </#list>
                            </#if>
                        </#if>
                        <#-- if inventory is not required check to see if it is out of stock and needs to have a message shown about that... -->
                        <#assign itemProduct = cartLine.getProduct() />
                        <#assign isStoreInventoryNotRequiredAndNotAvailable = Static["org.ofbiz.product.store.ProductStoreWorker"].isStoreInventoryRequiredAndAvailable(request, itemProduct, cartLine.getQuantity(), false, false) />
                        <#if isStoreInventoryNotRequiredAndNotAvailable && itemProduct.inventoryMessage?has_content>
                            (${itemProduct.inventoryMessage})
                        </#if>
                    <#else>
                        <#-- this is a non-product item -->
                        ${cartLine.getItemTypeDescription()!}: ${cartLine.getName()!}
                    </#if>
                    <#assign attrs = cartLine.getOrderItemAttributes()/>
                    <#if attrs?has_content>
                        <#assign attrEntries = attrs.entrySet()/>
                        <ul>
                            <#list attrEntries as attrEntry>
                                <li>${attrEntry.getKey()} : ${attrEntry.getValue()}</li>
                            </#list>
                        </ul>
                    </#if>
                    <#if (cartLine.getIsPromo() && cartLine.getAlternativeOptionProductIds()?has_content)>
                        <#-- Show alternate gifts if there are any... -->
                        <div class="tableheadtext">${uiLabelMap.OrderChooseFollowingForGift}:</div>
                        <select name="dummyAlternateGwpSelect${cartLineIndex}" onchange="setAlternateGwp(this);" class="selectBox">
                            <option value="">- ${uiLabelMap.OrderChooseAnotherGift} -</option>
                            <#list cartLine.getAlternativeOptionProductIds() as alternativeOptionProductId>
                                <#assign alternativeOptionName = Static["org.ofbiz.product.product.ProductWorker"].getGwpAlternativeOptionName(dispatcher, delegator, alternativeOptionProductId, requestAttributes.locale) />
                                <option value="<@ofbizUrl>setDesiredAlternateGwpProductId?alternateGwpProductId=${alternativeOptionProductId}&alternateGwpLine=${cartLineIndex}</@ofbizUrl>">${alternativeOptionName?default(alternativeOptionProductId)}</option>
                            </#list>
                        </select>
                        <#-- this is the old way, it lists out the options and is not as nice as the drop-down
                        <ul>
                            <#list cartLine.getAlternativeOptionProductIds() as alternativeOptionProductId>
                                <#assign alternativeOptionName = Static["org.ofbiz.product.product.ProductWorker"].getGwpAlternativeOptionName(delegator, alternativeOptionProductId, requestAttributes.locale) />
                                <li><a href="<@ofbizUrl>setDesiredAlternateGwpProductId?alternateGwpProductId=${alternativeOptionProductId}&alternateGwpLine=${cartLineIndex}</@ofbizUrl>" class="button">Select: ${alternativeOptionName?default(alternativeOptionProductId)}</a></li>
                            </#list>
                        </ul>
                        -->
                    </#if>
                </td>
                <#-- gift wrap option -->
                <#assign showNoGiftWrapOptions = false />
                <td >
                    <#assign giftWrapOption = lineOptionalFeatures.GIFT_WRAP! />
                    <#assign selectedOption = cartLine.getAdditionalProductFeatureAndAppl("GIFT_WRAP")! />
                    <#if giftWrapOption?has_content>
                        <select class="selectBox" name="option^GIFT_WRAP_${cartLineIndex}" onchange="javascript:document.cartform.submit()">
                            <option value="NO^">${uiLabelMap.EcommerceNoGiftWrap}</option>
                            <#list giftWrapOption as option>
                                <option value="${option.productFeatureId}" <#if ((selectedOption.productFeatureId)?? && selectedOption.productFeatureId == option.productFeatureId)>selected="selected"</#if>>${option.description} : ${option.amount?default(0)}</option>
                            </#list>
                        </select>
                    <#elseif showNoGiftWrapOptions>
                        <select class="selectBox" name="option^GIFT_WRAP_${cartLineIndex}" onchange="javascript:document.cartform.submit()">
                            <option value="">${uiLabelMap.EcommerceNoGiftWrap}</option>
                        </select>
                    <#else>
                        &nbsp;
                    </#if>
                </td>
                <#-- end gift wrap option -->
                <td align="right">
                    <#if cartLine.getIsPromo() || cartLine.getShoppingListId()??>
                        <#if fixedAssetExist == true>
                            <#if cartLine.getReservStart()??>
                                <table >
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>${cartLine.getReservStart()?string("yyyy-mm-dd")}</td>
                                        <td>${cartLine.getReservLength()?string.number}</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>${cartLine.getReservPersons()?string.number}</td>
                                        <td>
                            <#else>
                                <table >
                                    <tr>
                                        <td >--</td>
                                        <td>--</td>
                                    </tr>
                                    <tr>
                                    <td>--</td>
                                    <td>
                            </#if>
                            ${cartLine.getQuantity()?string.number}</td></tr></table>
                        <#else><#-- fixedAssetExist -->
                            ${cartLine.getQuantity()?string.number}
                        </#if>
                    <#else><#-- Is Promo or Shoppinglist -->
                        <#if fixedAssetExist == true><#if cartLine.getReservStart()??>
                            <table><tr><td>&nbsp;</td><td><input type="text" class="inputBox" size="10" name="reservStart_${cartLineIndex}" value=${cartLine.getReservStart()?string}/></td><td><input type="text" class="inputBox" size="2" name="reservLength_${cartLineIndex}" value="${cartLine.getReservLength()?string.number}"/></td></tr><tr><td>&nbsp;</td><td><input type="text" class="inputBox" size="3" name="reservPersons_${cartLineIndex}" value=${cartLine.getReservPersons()?string.number} /></td><td><#else>
                            <table><tr><td>--</td><td>--</td></tr><tr><td>--</td><td></#if>
                            <input size="6" class="inputBox" type="text" name="update_${cartLineIndex}" value="${cartLine.getQuantity()?string.number}" /></td></tr></table>
                        <#else><#-- fixedAssetExist -->
                            <input size="6" class="inputBox" type="text" name="update_${cartLineIndex}" value="${cartLine.getQuantity()?string.number}" />
                        </#if>
                    </#if>
                </td>
                <td align="right"><@ofbizCurrency amount=cartLine.getDisplayPrice() isoCode=shoppingCart.getCurrency()/></td>
                <td align="right"><@ofbizCurrency amount=cartLine.getOtherAdjustments() isoCode=shoppingCart.getCurrency()/></td>
                <td align="right"><@ofbizCurrency amount=cartLine.getDisplayItemSubTotal() isoCode=shoppingCart.getCurrency()/></td>
                <td><#if !cartLine.getIsPromo()><input type="checkbox" name="selectedItem" value="${cartLineIndex}" onclick="javascript:checkToggle(this);" /><#else>&nbsp;</#if></td>
            </tr>
        </#list>
    </tbody>
    </table>
</div>
</div>