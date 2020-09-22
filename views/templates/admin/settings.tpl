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
{*    Account*}
    <div id="ctr-1-account" class="container-fluid ctr-1 ctr-active">
        <div class="row row-settings">
            <div class="col"></div>
            <div class="col-sm-9 col-contact-detail">
                <div class="row">
                    <div class="col-sm-3">
                        <p style="color: #e07047;  font-weight: bold;">Contact detail</p>
                    </div>
                </div>
                <form method="post" class="contact-details-form">
                    <div class="row">
                        <div class="col-sm-3">
                            <label style="color: #e07047" for="">Contact person</label>
                        </div>
                        <div class="col-sm-3">
                            <label style="color: #e07047" for="">Phone</label>
                        </div>
                        <div class="col-sm-3">
                            <label style="color: #e07047" for="">Language</label>
                        </div>
                        <div class="col-sm-3"></div>
                    </div>

                    <div class="row">
                        <div class="col-sm-3">
                            <input type="text" name="contact_person" class="update-contact-detail">
                        </div>
                        <div class="col-sm-3">
                            <input type="text" name="phone" class="update-contact-detail">
                        </div>
                        <div class="col-sm-3">
                            <input type="text" name="language" class="update-contact-detail">
                        </div>
                        <div class="col-sm-3">
                            <button class="contact-detail-save" name="btn_contact_save" type="submit">Save</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col col-gap"></div>
            <div class="col-sm-2 col-menu">
                <div class="row"><div class="col"><a href="#" class="account">ACCOUNT</a></div></div>
                <div class="row"><div class="col"><a href="#" class="invoice">INVOICE</a></div></div>
                <div class="row"><div class="col"><a href="#" class="warehouse">WAREHOUSE</a></div></div>
            </div>
            <div class="col col-gap"></div>
        </div>

        <div class="row row-settings">
            <div class="col"></div>
            <div class="col-sm-9 col-email-address">
                <div class="row">
                    <div class="col-sm-3">
                        <p style="color: #e07047; font-weight: bold;">Email address</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-4"><label style="color: #e07047" for="">Email</label></div>
                    <div class="col-sm-1"><label style="color: #e07047" for="">Role</label></div>
                    <div class="col-sm-2"><label style="color: #e07047" for="">Company</label></div>
                    <div class="col-sm-2"><label style="color: #e07047" for="">Status</label></div>
                </div>
                {foreach $api_email_addresses as $api_email_address}
                    <form method="post" class="resend-verification-form">
                        <div class="row">
                            <div class="col-sm-3">
                                 <input type="text" name="verification_email" value="{$api_email_address['email']}" disabled style="border: unset; background-color: white;">
{*                                <p style="color: #b1b1b1;" id="verification-email" name="verification_email">{$api_email_address['email']}</p>*}
                            </div>
                            <div class="col-sm-2">
{*                                <p style="color: #b1b1b1;" id="verification-role" name="verification_role">{$api_email_address['role']}</p>*}
                                 <input type="text" name="verification_role" value="{$api_email_address['role']}" disabled style="border: unset; background-color: white;">
                            </div>
                            <div class="col-sm-2">
                                <input type="text" name="verification_role" value="" disabled style="border: unset; background-color: white;">
                            </div>
                            <div class="col-sm-1">
                                <input type="text" name="verification_role" value="" disabled style="border: unset; background-color: white;">
                            </div>
                            <div class="col-sm-4">
                                {* <input type="button" value="Resend verification" class="email-address-verification">*}
                                <button type="submit" name="btn_resend_verification" class="email-address-verification">Resend verification</button>
                            </div>
                        </div>
                    </form>
                    <br>
                {/foreach}

                <form method="post" class="update-email-address-form">
                    <div class="row">
                        <div class="col-sm-5">
                            <label style="color: #e07047" for="">Add new email address</label>
                        </div>
                        <div class="col-sm-5">
                            <label style="color: #e07047" for="">Add new role</label>
                        </div>
                        <div class="col-sm-2"></div>
                    </div>
                    <div class="row">
                        <div class="col-sm-5">
                            <input type="email" name="add_new_email_address" class="email-css">
                        </div>
                        <div class="col-sm-5">
                            <input type="text" name="add_new_role">
                        </div>
                        <div class="col-sm-2">
                            <button type="submit" class="email-address-add" name="update_email_address">Add</button>
{*                            <input type="button" value="Add" class="email-address-add">*}
                        </div>
                    </div>
                </form>
            </div>
            <div class="col"></div>
            <div class="col-sm-2"></div>
            <div class="col"></div>
        </div>

        <div class="row row-settings">
            <div class="col"></div>
            <div class="col-sm-9 col-change-password">
                <div class="row">
                    <div class="col-sm-3">
                        <p style="color: #e07047; font-weight: bold;">Change password</p>
                    </div>
                </div>
                <form method="post" class="change-password-form">
                    <div class="row">
                        <div class="col-sm-3"><label style="color: #e07047" for="">Current password</label></div>
                        <div class="col-sm-3"><label style="color: #e07047" for="">New password</label></div>
                        <div class="col-sm-3"><label style="color: #e07047" for="">Confirm password</label></div>
                        <div class="col-sm-3"></div>
                    </div>
                    <div class="row">
                        <div class="col-sm-3">
                            <input type="password" name="current_password">
                        </div>
                        <div class="col-sm-3">
                            <input type="password" name="new_password">
                        </div>
                        <div class="col-sm-3">
                            <input type="password" name="confirm_password">
                        </div>
{*                        <div class="col-sm-3"><input type="button" value="Save" class="change-password-save"></div>*}
                        <button type="submit" name="change_password" class="change-password-save">Save</button>
                    </div>
                </form>
            </div>
            <div class="col"></div>
            <div class="col-sm-2"></div>
            <div class="col"></div>
        </div>

        <div class="row row-settings">
            <div class="col"></div>
            <div class="col-sm-9 col-delete-account">
                <div class="row">
                    <div class="col-sm-3"><p style="color: #e07047; font-weight: bold;">Delete account</p></div>
                </div>
                <div class="row">
                    <div class="col-sm-12" style="display: flex;">
                        <span class="material-icons" style="color: #e07047;  padding-right: 5px;">info</span>
                        <p style="color: #b1b1b1;" >Once you request your account to be deleted you have until November 29. 2020 to keep this account</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-8">
                        <p style="color: #b1b1b1;" >Please note:</p>
                        <ul>
                            <li style="color: #b1b1b1;" >You will not be able to create shipping anymore</li>
                            <li style="color: #b1b1b1;" >All you account data will be permanently removed in 6 months</li>
                            <li style="color: #b1b1b1;" >We recommend you to export you data before deleting this account</li>
                        </ul>
                    </div>
                    <form method="post" class="delete-account-form">
                        <div class="col-sm-4">
{*                            <input type="button" value="Delete account" class="delete-account-btn">*}
                            <input type="hidden" name="_id">
                            <button type="submit" name="btn_delete_account" class="delete-account-btn">Delete account</button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col"></div>
            <div class="col-sm-2"></div>
            <div class="col"></div>
        </div>
    </div>

{*    Invoice*}
    <div id="ctr-2-invoice" class="container-fluid ctr-2 ctr-active">
        <div class="row row-settings">
            <div class="col"></div>
            <div class="col-sm-9 col-contact-detail">
                <div class="row">
                    <div class="col-sm-3">
                        <p style="color: #e07047; font-weight: bold;">Billing information</p>
                    </div>
                </div>
                <form method="post">
                    <div class="row">
                        <div class="col-sm-6">
                            <p>This account is billed to a Visa card ending in 0123</p>
                        </div>
                        <div class="col-sm-3">
                            <button class="credit-cards remove-credit-card-btn">Remove credit card</button>
                        </div>
                        <div class="col-sm-3">
                            <button class="credit-cards change-credit-card-btn">Change credit card</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col col-gap"></div>
            <div class="col-sm-2 col-menu">
                <div class="row"><div class="col"><a href="#" class="account">ACCOUNT</a></div></div>
                <div class="row"><div class="col"><a href="#" class="invoice">INVOICE</a></div></div>
                <div class="row"><div class="col"><a href="#" class="warehouse">WAREHOUSE</a></div></div>
            </div>
            <div class="col col-gap"></div>
        </div>
        <div class="row row-settings">
            <div class="col"></div>
            <div class="col-sm-9 col-contact-detail">
                <div class="row">
                    <div class="col-sm-10">
                        <p style="color: #e07047; font-weight: bold;">Invoice</p>
                    </div>
                    <div class="col-sm-2" style="display: flex;">
                        <p style="padding-right: 5px; color: #e07047; font-weight: bold;">Download all</p>
                        <i class="material-icons" style="font-size: 20px; color: #e07047; font-weight: bold;">system_update_alt</i>
                    </div>
                </div>

                <div class="row">
                    <table class="table">
                        <tbody>
                        <tr>
                            <td>Mark</td>
                            <td>Otto</td>
                            <td>@mdo</td>
                        </tr>
                        <tr>
                            <td>Jacob</td>
                            <td>Thornton</td>
                            <td>@fat</td>
                        </tr>
                        <tr>
                            <td>Larry</td>
                            <td>the Bird</td>
                            <td>@twitter</td>
                        </tr>
                        </tbody>
                    </table>
                </div>

            </div>
            <div class="col"></div>
            <div class="col-sm-2"></div>
            <div class="col"></div>
        </div>
    </div>

{*    Warehouse*}
    <div id="ctr-3-warehouse" class="container-fluid ctr-3 ctr-active">
        <div class="row row-settings">
            <div class="col"></div>
            <div class="col-sm-9 col-contact-detail">
                <div class="row">
                    <div class="col-sm-3">
                        <p style="color: #e07047; font-weight: bold;">Warehouse</p>
                    </div>
                </div>
                <form method="post" class="add-warehouse-form">
                    <div class="row">
                        <div class="col-sm-5">
                            <label style="color: #e07047;" for="">Warehouse name</label>
                        </div>
                        <div class="col-sm-5">
                            <label style="color: #e07047;" for="">Warehouse address</label>
                        </div>
                        <div class="col-sm-2"></div>
                    </div>

                    <div class="row">
                        <div class="col-sm-5">
                            <input type="text" name="warehouse_name" class="add-new-warehouse-input" >
                        </div>
                        <div class="col-sm-5">
                            <input type="text" class="add-new-warehouse-input" name="warehouse_address" id="warehouse-address">

                            {*                    hidden*}
                            <input type="hidden" name="warehouse_lat" id="warehouse-lat">
                            <input type="hidden" name="warehouse_lng" id="warehouse-lng">

                            <input type="hidden" name="warehouse_city" id="warehouse-city">
                            <input type="hidden" name="warehouse_state" id="warehouse-state">
                            <input type="hidden" name="warehouse_country" id="warehouse-country">
                            <input type="hidden" name="warehouse_zip" id="warehouse-zip">

                            {*                    hidden-end*}
                        </div>
                        <div class="col-sm-2">
                            <button type="submit" class="add-new-warehouse-btn" style="width: 100px;" name="add_new_warehouse_btn">Add</button>
                        </div>
                    </div>
                </form>
                <div class="row">
                    <div class="col-sm-5">
                        <p style="color: #e07047; margin-top: 15px; font-weight: bold;">Warehouse available</p>
                    </div>
                </div>
                <br>
                <div class="row">
                    <table class="table warehouse-table">
{*                        <tbody>*}
{*                        {foreach $api_warehouses as $api_warehouse}*}
{*                            <tr>*}
{*                                <td scope="col" style="width: 165px;">{$api_warehouse['name']}</td>*}
{*                                <td scope="col" style="padding-left: 60px; width: 250px; ">{$api_warehouse['address']}</td>*}
{*                                <td scope="col" style="padding-left: 100px;"><a style="text-decoration: none" href="#"><i class="material-icons" style="font-size: 15px; color: grey;">create</i></a></td>*}
{*                                <td scope="col" style="padding-left: 20px;"><a href="#" class="delete-warehouse" data-id_warehouse="{$api_warehouse['_id']}"><i class="material-icons" style="font-size: 15px; color: grey;">delete</i></a></td>*}
{*                            </tr>*}
{*                        {/foreach}*}
{*                        </tbody>*}
                    </table>
                </div>
            </div>
            <div class="col col-gap"></div>
            <div class="col-sm-2 col-menu">
                <div class="row"><div class="col"><a href="#" class="account">ACCOUNT</a></div></div>
                <div class="row"><div class="col"><a href="#" class="invoice">INVOICE</a></div></div>
                <div class="row"><div class="col"><a href="#" class="warehouse">WAREHOUSE</a></div></div>
            </div>
            <div class="col col-gap"></div>
        </div>
    </div>
</div>

{*modal map --------------------------------------------------------------------------------------------------------------------------------------*}

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>

            </div>
            <div class="modal-body">
                <div class="pac-card" id="pac-card">
                    <div>
                        <div id="title">
                            Select Pickup Location
                        </div>
                        <div id="type-selector" class="pac-controls">
                            <input type="radio" name="type" id="changetype-all" checked="checked">
                            <label for="changetype-all">All</label>
                        </div>
                        <div id="strict-bounds-selector" class="pac-controls">
                            <input type="checkbox" id="use-strict-bounds" value="">
                            <label for="use-strict-bounds">Strict Bounds</label>
                        </div>
                    </div>
                    <div id="pac-container">
                        <input id="pac-input" type="text"
                               placeholder="Enter a location">
                    </div>
                </div>
                <div id="map"></div>
                <div id="infowindow-content">
                    <img src="" width="16" height="16" id="place-icon">
                    <span id="place-name"  class="title"></span><br>
                    <span id="place-address"></span>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="dismiss-button" class="btn btn-default" data-dismiss="modal">Select</button>
            </div>
        </div>
    </div>
</div>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBXXUe1UPwcYKHx8L3drP_vJks8zl9kla4&libraries=places&callback=initMap" type="text/javascript"></script>
