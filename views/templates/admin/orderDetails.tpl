<div class="frank">
    <div class="container-header">
        <div class="frank-logo">
            <a href="#">Frank</a>
        </div>
        <div class="frank-shipping">
            <a href="{$shipping}" class="shipping-link">Shipping</a>
        </div>
        <div class="frank-returns">
            <a href="{$returns}" class="returns-link">Returns</a>
        </div>
        <div class="frank-chart">
            <a href="{$settings}"><i class="material-icons" id="settings">settings</i></a>
        </div>
        <div class="frank-settings">
            <a href="#"><i class="material-icons">assessment</i></a>
        </div>
    </div>

{*    <div class="tab-mid-container">*}
{*        <a href="#" class="upload-file upload">Upload file</a>*}
{*        <a href="#" class="upload-icon upload"><i class="material-icons">system_update_alt</i></a>*}
{*        <button class="btn-new-shipment"><i class="material-icons" style="font-size: 14px; font-weight: bold;">add</i> New shipment</button>*}
{*    </div>*}
    <div class="detail-container">
        <div class="status-tab">
            <input id="order-status" type="hidden" value="{$get_order_by_id['status']}">
            <div id="order-placed-main" class="order-placed">
                1 <a href="#" id="order-placed-href">Order placed</a>
                <p>{$get_order_by_id['createdAt']|date_format:"%m/%m/%Y"}</p>
            </div>
            <div id="sent-with-main" class="sent-with">
                2 <a href="#" id="sent-with-href">Sent with</a>
                <p>{$get_order_by_id['deliveryType']}</p>
            </div>
            <div id="delivery-in-progress-main" class="delivery-in-progress">
                3 <a href="#" id="delivery-in-progress-href">Delivery in progress</a>
                <p>{$get_order_by_id['pickupDate']|date_format:"%m/%m/%Y"}</p>
            </div>
            <div id="delivered-main" class="delivered">
                4 <a href="#" id="delivered-href">Delivered</a>
                <p>{$get_order_by_id['dropoff']['country']}</p>
            </div>
        </div>
        <div class="row image-map" style="margin: 30px;">
            <div class="col-sm-2 product-image">
                <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                    <div class="carousel-inner">
                        <div class="item active">
                            <img class="d-block w-100" src="{$get_order_by_id['commodities'][0]['images'][0]}" alt="First slide" width="100%">
                            <h5>{$get_order_by_id['commodities'][0]['name']}</h5>
                            <p>Quantity {$get_order_by_id['commodities'][0]['quantity']}</p>
                        </div>
                        {foreach $get_order_by_id['commodities'] as $commodity}
                            <div class="item">
                                <img class="d-block w-100" src="{$commodity['images'][0]}" alt="{$commodity['name']}" width="100%">
                                <h5>{$commodity['name']}</h5>
                                <p>Quantity {$commodity['quantity']}</p>
                            </div>
                        {/foreach}
                    </div>
                    <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </div>
            <div class="col-sm-1"></div>
            <div class="col-sm-9 order-map" id="map"></div>

            <input type="hidden" id="pickup_lat" value="{$get_order_by_id['pickup']['location'][1]}">
            <input type="hidden" id="pickup_lng" value="{$get_order_by_id['pickup']['location'][0]}">

            <input type="hidden" id="dropoff_lat" value="{$get_order_by_id['dropoff']['location'][1]}">
            <input type="hidden" id="dropoff_lng" value="{$get_order_by_id['dropoff']['location'][0]}">
        </div>
        <div class="row">
            <div class="col-sm-2 tracking-number">
                <div>
                    <span class="material-icons">account_balance_wallet</span>
                </div>
                <div>
                    <p>Tracking number</p>
                    <p>{$get_order_by_id['orderNumber']}</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBXXUe1UPwcYKHx8L3drP_vJks8zl9kla4&libraries=places&callback=initMap" type="text/javascript"></script>