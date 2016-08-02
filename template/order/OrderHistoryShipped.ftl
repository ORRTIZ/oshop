<#if porderHeaderList?has_content>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.OrderPurchaseHistory}</h3>
    </div>
    <div class="panel-body"
        <table id="orderPurchaseHistory" summary="This table display order purchase history.">
        <thead>
            <tr>
                <th>${uiLabelMap.CommonDate}</th>
                <th>${uiLabelMap.OrderOrder} ${uiLabelMap.CommonNbr}</th>
                <th>${uiLabelMap.CommonAmount}</th>
                <th>${uiLabelMap.CommonStatus}</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <#if porderHeaderList?has_content>
                <#list porderHeaderList as porderHeader>
                    <#assign pstatus = porderHeader.getRelatedOne("StatusItem", true) />
                    <tr>
                        <td>${porderHeader.orderDate.toString()}</td>
                        <td>${porderHeader.orderId}</td>
                        <td><@ofbizCurrency amount=porderHeader.grandTotal isoCode=porderHeader.currencyUom /></td>
                        <td>${pstatus.get("description",locale)}</td>
                        <td><a href="<@ofbizUrl>order?orderId=${porderHeader.orderId}</@ofbizUrl>" class="button">${uiLabelMap.CommonView}</a></td>
                    </tr>
                </#list>
            <#else>
                <tr><td colspan="5">${uiLabelMap.OrderNoOrderFound}</td></tr>
            </#if>
        </tbody>
        </table>
    </div>
</div>
</#if>