<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.OrderIsThisGift}?</h3>
    </div>
    <div class="panel-body">
        <table>
              <tr>
                <td colspan="2">
                  <div>
                        <input type="radio" <#if "Y" == shoppingCart.getIsGift()?default("N")>checked="checked"</#if> name="is_gift" value="true" /><span>&nbsp;${uiLabelMap.CommonYes}</span>
                        &nbsp;
                        <input type="radio" <#if "Y" != shoppingCart.getIsGift()?default("N")>checked="checked"</#if> name="is_gift" value="false" /><span>&nbsp;${uiLabelMap.CommonNo}</span>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.OrderGiftMessage}</h3>
    </div>
    <div class="panel-body">
        <table>
            <tr>
                <td colspan="2">
                    <textarea class="textAreaBox" cols="30" rows="3" wrap="hard" name="gift_message">${shoppingCart.getGiftMessage()!}</textarea>
                </td>
            </tr>
        </table>
    </div>
</div>