<#if showPromoText?? && showPromoText>
    <div>
        <div>
            <h2>${uiLabelMap.OrderSpecialOffers}</h2>
        </div>
        <div>
            <#-- show promotions text -->
            <ul>
                <#list productPromos as productPromo>
                    <li><a href="<@ofbizUrl>showPromotionDetails?productPromoId=${productPromo.productPromoId}</@ofbizUrl>" class="linktext">[${uiLabelMap.CommonDetails}]</a>${StringUtil.wrapString(productPromo.promoText!)}</li>
                </#list>
            </ul>
            <div><a href="<@ofbizUrl>showAllPromotions</@ofbizUrl>" class="button">${uiLabelMap.OrderViewAllPromotions}</a></div>
            
        </div>
    </div>
</#if>
