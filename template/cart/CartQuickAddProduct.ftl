<div class="panel">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.CommonQuickAdd}</h3>
    </div>
    <div class="panel-body">
        <form method="post" action="<@ofbizUrl>additem<#if requestAttributes._CURRENT_VIEW_?has_content>/${requestAttributes._CURRENT_VIEW_}</#if></@ofbizUrl>" name="quickaddform">
            <fieldset>
            ${uiLabelMap.CommonProduct} <input type="text" class="inputBox" name="add_product_id" value="${requestParameters.add_product_id!}" />
            <#-- check if rental data present  insert extra fields in Quick Add-->
            <#if (product?? && product.getString("productTypeId") == "ASSET_USAGE") || (product?? && product.getString("productTypeId") == "ASSET_USAGE_OUT_IN")>
                ${uiLabelMap.EcommerceStartDate}: <input type="text" class="inputBox" size="10" name="reservStart" value="${requestParameters.reservStart?default("")}" />
                ${uiLabelMap.EcommerceLength}: <input type="text" class="inputBox" size="2" name="reservLength" value="${requestParameters.reservLength?default("")}" />
                </div>
                <div>
                    &nbsp;&nbsp;${uiLabelMap.OrderNbrPersons}: <input type="text" class="inputBox" size="3" name="reservPersons" value="${requestParameters.reservPersons?default("1")}" />
            </#if>
            ${uiLabelMap.CommonQuantity}: <input type="text" class="inputBox" size="5" name="quantity" value="${requestParameters.quantity?default("1")}" />
            <input type="submit" class="btn btn-success btn-sm" value="${uiLabelMap.OrderAddToCart}" />
            <#-- <a href="javascript:document.quickaddform.submit()" class="button"><span>[${uiLabelMap.OrderAddToCart}]</span></a> -->
            </fieldset>
        </form>
    </div>
</div>