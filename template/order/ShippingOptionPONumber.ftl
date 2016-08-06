<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.OrderPoNumber}?</h3>
    </div>
    <div class="panel-body">
        <table>
            <tr>
                <td colspan="2">
                    <#if shoppingCart.getPoNumber()?? && shoppingCart.getPoNumber() != "(none)">
                        <#assign currentPoNumber = shoppingCart.getPoNumber()>
                    </#if>
                    <input type="text" class="inputBox" name="correspondingPoId" size="15" value="${currentPoNumber!}"/>
                </td>
            </tr>
        </table>
    </div>
</div>
              