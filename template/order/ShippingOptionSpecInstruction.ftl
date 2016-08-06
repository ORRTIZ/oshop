<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">${uiLabelMap.OrderSpecialInstructions}?</h3>
    </div>
    <div class="panel-body">
        <table>
            <tr>
                <td colspan="2">
                    <textarea class="textAreaBox" cols="40" rows="5" wrap="hard" name="shipping_instructions">${shoppingCart.getShippingInstructions()!}</textarea>
                </td>
            </tr>
        </table>
    </div>
</div>