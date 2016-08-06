<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.OrderShipAllAtOnce}?</h3>
    </div>
    <div class="panel-body">
        <table>
            <tr>
                <td valign="top">
                    <input type="radio" <#if "Y" != shoppingCart.getMaySplit()?default("N")>checked="checked"</#if> name="may_split" value="false" />&nbsp;
                </td>
                <td valign="top">
                    <div>${uiLabelMap.OrderPleaseWaitUntilBeforeShipping}.</div>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <input <#if "Y" == shoppingCart.getMaySplit()?default("N")>checked="checked"</#if> type="radio" name="may_split" value="true" />&nbsp;
                </td>
                <td valign="top">
                    <div>${uiLabelMap.OrderPleaseShipItemsBecomeAvailable}.</div>
                </td>
            </tr>
        </table>
    </div>
</div>