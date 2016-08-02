<table class="adjustments" width="100%">
    <#if shoppingCart.getAdjustments()?has_content>
        <tr>
            <th>${uiLabelMap.CommonSubTotal}:</th>
            <td aling="right"><@ofbizCurrency amount=shoppingCart.getDisplaySubTotal() isoCode=shoppingCart.getCurrency()/></td>
            <td>&nbsp;</td>
        </tr>
        <#if (shoppingCart.getDisplayTaxIncluded() > 0.0)>
          <tr>
            <th>${uiLabelMap.OrderSalesTaxIncluded}:</th>
            <td><@ofbizCurrency amount=shoppingCart.getDisplayTaxIncluded() isoCode=shoppingCart.getCurrency()/></td>
            <td>&nbsp;</td>
          </tr>
        </#if>
        <#list shoppingCart.getAdjustments() as cartAdjustment>
              <#assign adjustmentType = cartAdjustment.getRelatedOne("OrderAdjustmentType", true) />
              <tr>
                <th>
                    ${uiLabelMap.EcommerceAdjustment} - ${adjustmentType.get("description",locale)!}
                    <#if cartAdjustment.productPromoId?has_content><a href="<@ofbizUrl>showPromotionDetails?productPromoId=${cartAdjustment.productPromoId}</@ofbizUrl>" class="button">${uiLabelMap.CommonDetails}</a></#if>:
                </th>
                <td><@ofbizCurrency amount=Static["org.ofbiz.order.order.OrderReadHelper"].calcOrderAdjustment(cartAdjustment, shoppingCart.getSubTotal()) isoCode=shoppingCart.getCurrency()/></td>
                <td>&nbsp;</td>
              </tr>
        </#list>
    </#if>
    <tr>
      <th>${uiLabelMap.EcommerceCartTotal}:</th>
      <td><@ofbizCurrency amount=shoppingCart.getDisplayGrandTotal() isoCode=shoppingCart.getCurrency()/></td>
    </tr>
    <#if itemsFromList>
        <tr>
          <td>L - ${uiLabelMap.EcommerceItemsfromShopingList}.</td>
        </tr>
    </#if>
    <#if promoItems>
        <tr>
            <td>P - ${uiLabelMap.EcommercePromotionalItems}.</td>
        </tr>
    </#if>
    <#if !itemsFromList && !promoItems>
        <tr>
          <td>&nbsp;</td>
        </tr>
    </#if>
        <tr>
          <td>
              <#if sessionAttributes.userLogin?has_content && sessionAttributes.userLogin.userLoginId != "anonymous">
              <select name="shoppingListId" class="selectBox">
                <#if shoppingLists?has_content>
                  <#list shoppingLists as shoppingList>
                    <option value="${shoppingList.shoppingListId}">${shoppingList.listName}</option>
                  </#list>
                </#if>
                <option value="">---</option>
                <option value="">${uiLabelMap.OrderNewShoppingList}</option>
              </select>
              &nbsp;&nbsp;
              <a href="javascript:addToList();" class="button">${uiLabelMap.EcommerceAddSelectedtoList}</a>&nbsp;&nbsp;
              <#else>
               ${uiLabelMap.OrderYouMust} <a href="<@ofbizUrl>checkLogin/showcart</@ofbizUrl>" class="button">${uiLabelMap.CommonBeLogged}</a>
                ${uiLabelMap.OrderToAddSelectedItemsToShoppingList}.&nbsp;
              </#if>
          </td>
        </tr>
        <tr>
          <td>
              <#if sessionAttributes.userLogin?has_content && sessionAttributes.userLogin.userLoginId != "anonymous">
              &nbsp;&nbsp;
              <a href="<@ofbizUrl>createCustRequestFromCart</@ofbizUrl>" class="button">${uiLabelMap.OrderCreateCustRequestFromCart}</a>&nbsp;&nbsp;
              &nbsp;&nbsp;
              <a href="<@ofbizUrl>createQuoteFromCart</@ofbizUrl>" class="button">${uiLabelMap.OrderCreateQuoteFromCart}</a>&nbsp;&nbsp;
              <#else>
               ${uiLabelMap.OrderYouMust} <a href="<@ofbizUrl>checkLogin/showcart</@ofbizUrl>" class="button">${uiLabelMap.CommonBeLogged}</a>
                ${uiLabelMap.EcommerceToOrderCreateCustRequestFromCart}.&nbsp;
              </#if>
          </td>
        </tr>
        <tr>
          <td>
            <input type="checkbox" onclick="javascript:document.cartform.submit()" name="alwaysShowcart" <#if shoppingCart.viewCartOnAdd()>checked="checked"</#if>/>${uiLabelMap.EcommerceAlwaysViewCartAfterAddingAnItem}.
          </td>
        </tr>
      </table>