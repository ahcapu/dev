<?php
/**
 * 2007-2020 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License (AFL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/afl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 *  @author    PrestaShop SA <contact@prestashop.com>
 *  @copyright 2007-2020 PrestaShop SA
 *  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
 *  International Registered Trademark & Property of PrestaShop SA
 */

if (!defined('_PS_VERSION_')) {
    exit;
}
class Frank extends CarrierModule
{
    public $id_carrier;
    private $frank_api;

    public function __construct()
    {
        $this->name = 'frank';
        $this->tab = 'shipping_logistics';
        $this->version = '1.0.0';
        $this->author = 'HiTech';
        $this->need_instance = 0;
        $this->error_count = 0;

        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('Frank');
        $this->description = $this->l('Here is the Frank module for Prestashop');

        $this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_);

        include_once _PS_MODULE_DIR_ . 'frank/api/FrankApi.php';

        $this->frank_api = new FrankApi();

    }

    public function install()
    {
        if (
            !parent::install() ||
            !$this->installCarriers() ||
            !$this->registerHook('actionCarrierUpdate') ||
            !$this->registerHook('header') ||
            !$this->registerHook('displayOrderConfirmation') ||
            !$this->registerHook('displayCarrierList') ||
            !$this->installModuleTab('AdminFrankShipping', 'Shipping', Tab::getIdFromClassName('AdminParentShipping')) ||
            !$this->installModuleTab('AdminFrankReturns', 'Returns', Tab::getIdFromClassName('AdminParentShipping')) ||
            !$this->installModuleTab('AdminFrankPickup', 'Pickup', Tab::getIdFromClassName('AdminParentShipping')) ||
            !$this->installModuleTab('AdminFrankOrderDetails', 'OrderDetails', 0) ||
            !$this->installModuleTab('AdminFrankNewShipment', 'NewShipment', 0) ||
            !$this->installModuleTab('AdminFrankSettings', 'Settings', 0)
        )
            return false;

        return true;
    }

    public function uninstall()
    {
        return
            parent::uninstall()
            && $this->unregisterHook('header')
            && $this->unregisterHook('displayOrderConfirmation')
//            && $this->unregisterHook('actionCartSave')
            && $this->uninstallModuleTab('AdminFrankShipping')
            && $this->uninstallModuleTab('AdminFrankReturns')
            && $this->uninstallModuleTab('AdminFrankSettings')
            && $this->uninstallModuleTab('AdminFrankOrderDetails')
            && $this->uninstallModuleTab('AdminFrankNewShipment')
            && $this->uninstallModuleTab('AdminFrankPickup');
    }

    // Tabs install
    private function installModuleTab($tab_class, $tab_name, $id_tab_parent)
    {
        $tab = new Tab();

        $languages = Language::getLanguages(false);
        foreach ($languages as $language) {
            $tab->name[$language['id_lang']] = $tab_name;
        }
        $tab->class_name = $tab_class;
        $tab->module = $this->name;
        $tab->id_parent = $id_tab_parent;

        if (!$tab->save()) {
            return false;
        }
        return true;
    }

    // Tabs uninstall
    private function uninstallModuleTab($tab_class)
    {
        $id_tab = Tab::getIdFromClassName($tab_class);
        if ($id_tab != 0) {
            $tab = new Tab($id_tab);
            $tab->delete();
            return true;
        }
        return false;
    }

    public function getContent()
    {
        $countries = Country::getCountries($this->context->country);
        if (Tools::isSubmit('submitFrankModule')) {

            if (
                Tools::getValue('first_name') &&
                Tools::getValue('last_name') &&
                Tools::getValue('email') &&
                Tools::getValue('password') &&
                Tools::getValue('confirm_password') &&
                Tools::getValue('address_1') &&
                Tools::getValue('city') &&
                Tools::getValue('postal_code') &&
                Tools::getValue('country_code') &&
                Tools::getValue('country') &&
                Tools::getValue('mobile_number') &&
                Tools::getValue('latitude') &&
                Tools::getValue('longitude') &&
                Tools::getValue('number_of_stores') >=0
            ) {

                if (Tools::getValue('password') === Tools::getValue('confirm_password')) {
                    $form_data = $this->getConfigFormValues();
                    if (empty(Configuration::get('FRANK_ID')) && empty(Configuration::get('FRANK_TOKEN'))) {
                        $api_data = $this->postApiData();
                        $res = $this->frank_api->doCurlRequest("https://p-post.herokuapp.com/api/v1/stores/signup", $api_data);
                        $res = json_decode($res, true);

                        if ($res['status'] == 200) {
                            Configuration::updateValue('FRANK_TOKEN', $res['data']['token']);
                            Configuration::updateValue('FRANK_ID', $res['data']['_id']);
                            foreach ($form_data as $key => $value) {
                                if ($key == 'FRANK_PASSWORD') {
                                    $value = md5($value);
                                }
                                Configuration::updateValue($key, $value);
                            }
                        } else {
                            $this->context->smarty->assign('api_error', 'ko');
                        }
                    } else {
                        $this->context->smarty->assign('already_registered', 'ok');
                    }
                }
                else {
                    $this->context->smarty->assign('error_message_password', 'ko');
                }
            }
            else {
                $this->context->smarty->assign('error_message_credentials', 'ko');
            }
            $this->context->smarty->assign('confirmation', 'ok');
        }

        $this->context->smarty->assign('countries', $countries);
        return $this->display(__FILE__, 'views/templates/admin/signup.tpl');
    }

    protected function getConfigFormValues()
    {
        return array(
            'FRANK_FIRSTNAME' => Tools::getValue('first_name'),
            'FRANK_LASTNAME' => Tools::getValue('last_name'),
            'FRANK_EMAIL' => Tools::getValue('email'),
            'FRANK_PASSWORD' => Tools::getValue('password'),
            'FRANK_ADDRESS_1' => Tools::getValue('address_1'),
            'FRANK_ADDRESS_2' => Tools::getValue('address_2'),
            'FRANK_ADDRESS_3' => Tools::getValue('address_3'),
            'FRANK_CITY' => Tools::getValue('city'),
            'FRANK_ZIPCODE' => Tools::getValue('postal_code'),
            'FRANK_COUNTRY' => Tools::getValue('country'),
            'FRANK_CODE' => Tools::getValue('country_code'),
            'FRANK_MOBILE' => Tools::getValue('mobile_number'),
            'FRANK_BUSINESS' => Tools::getValue('number_of_stores'),
            'FRANK_FACEBOOK' => Tools::getValue('facebook'),
            'FRANK_INSTAGRAM' => Tools::getValue('instagram'),
            'FRANK_RETURN' => Tools::getValue('acceptsReturn'),
            'FRANK_LATITUDE' => Tools::getValue('latitude'),
            'FRANK_LONGITUDE' => Tools::getValue('longitude'),
            'UNIQUE_ID' => md5(Configuration::get('PS_SHOP_DOMAIN') . Configuration::get('PS_SHOP_NAME') . Tools::getValue('email')),

        );
    }

    protected function postApiData()
    {
        $form_data = $this->getConfigFormValues();
        return array(
            'name' => Configuration::get('PS_SHOP_NAME'),
            'storeURL' => Configuration::get('PS_SHOP_DOMAIN'),
            'platform' => 'Prestashop',
            'location1' => ['longitude' => $form_data['FRANK_LONGITUDE'], 'latitude' => $form_data['FRANK_LATITUDE'] ],
            'firstName' => $form_data['FRANK_FIRSTNAME'],
            'lastName' => $form_data['FRANK_LASTNAME'],
            'email' => $form_data['FRANK_EMAIL'],
            'password' => $form_data['FRANK_PASSWORD'],
            'address1' => $form_data['FRANK_ADDRESS_1'],
            'address2' => $form_data['FRANK_ADDRESS_2'],
            'address3' => $form_data['FRANK_ADDRESS_3'],
            'city' => $form_data['FRANK_CITY'],
            'country' => $form_data['FRANK_ZIPCODE'],
            'countryCode' => $form_data['FRANK_COUNTRY'],
            'zipCode' => $form_data['FRANK_CODE'],
            'mobile' => $form_data['FRANK_MOBILE'],
            'totalStores' => (int)$form_data['FRANK_BUSINESS'],

            'facebook' => $form_data['FRANK_FACEBOOK'],
            'instagram' => $form_data['FRANK_INSTAGRAM'],
            'acceptsReturn' => $form_data['FRANK_RETURN'] = 'Yes' ? true : false,

            'uniqueID' => $form_data['UNIQUE_ID']
        );
    }

    public function installCarriers()
    {
        $id_lang_default = Language::getIsoById(Configuration::get('PS_LANG_DEFAULT'));
        $carriers_list = array(
            'FRANK_FLEX' => 'Flex',
            'FRANK_GREEN' => 'Green',
            'FRANK_CLASSIC' => 'Classic',
        );
        foreach ($carriers_list as $carrier_key => $carrier_name)
            if (Configuration::get($carrier_key) < 1)
            {
                // Create new carrier
                $carrier = new Carrier();
                $carrier->name = $carrier_name;
                $carrier->id_tax_rules_group = 0;
                $carrier->active = 1;
                $carrier->deleted = 0;
                foreach (Language::getLanguages(true) as $language)
                    $carrier->delay[(int)$language['id_lang']] = 'Frank '.$carrier_name;
                $carrier->shipping_handling = false;
                $carrier->range_behavior = 0;
                $carrier->is_module = true;
                $carrier->shipping_external = true;
                $carrier->external_module_name = $this->name;
                $carrier->need_range = true;
                if (!$carrier->add())
                    return false;

                // Associate carrier to all groups
                $groups = Group::getGroups(true);
                foreach ($groups as $group)
                    Db::getInstance()->insert('carrier_group', array('id_carrier' => (int)$carrier->id, 'id_group' => (int)$group['id_group']));

                // Create price range
                $rangePrice = new RangePrice();
                $rangePrice->id_carrier = $carrier->id;
                $rangePrice->delimiter1 = '0';
                $rangePrice->delimiter2 = '10000';
                $rangePrice->add();

                // Create weight range
                $rangeWeight = new RangeWeight();
                $rangeWeight->id_carrier = $carrier->id;
                $rangeWeight->delimiter1 = '0';
                $rangeWeight->delimiter2 = '10000';
                $rangeWeight->add();

                // Associate carrier to all zones
                $zones = Zone::getZones(true);
                foreach ($zones as $zone)
                {
                    Db::getInstance()->insert('carrier_zone', array('id_carrier' => (int)$carrier->id, 'id_zone' => (int)$zone['id_zone']));
                    Db::getInstance()->insert('delivery', array('id_carrier' => (int)$carrier->id, 'id_range_price' => (int)$rangePrice->id, 'id_range_weight' => NULL, 'id_zone' => (int)$zone['id_zone'], 'price' => '0'));
                    Db::getInstance()->insert('delivery', array('id_carrier' => (int)$carrier->id, 'id_range_price' => NULL, 'id_range_weight' => (int)$rangeWeight->id, 'id_zone' => (int)$zone['id_zone'], 'price' => '0'));
                }

                // Copy the carrier logo
                copy(dirname(__FILE__).'/views/img/'.$carrier_key.'.jpg', _PS_SHIP_IMG_DIR_.'/'.(int)$carrier->id.'.jpg');

                // Save the carrier ID in the Configuration table
                Configuration::updateValue($carrier_key, $carrier->id);
            }

        return true;
    }

    public function getOrderShippingCost($params, $shipping_cost)
    {
        if ($this->activate()) {
            if (Context::getContext()->customer->logged == true && !empty($params->id_carrier)) {
                $res = null;
                $id_address_delivery = Context::getContext()->cart->id_address_delivery;
                $address = new Address($id_address_delivery);
                $addressArray = (array) $address;

                $carrierName = $this->getCarrier($params->id_carrier);
                $carrierName = $carrierName[0]['name'];

                $prodArr = $params->getProducts();

                $prodDetail = [];
                $totalWeight = 0;
                $totalLength = 0;
                $totalWidth = 0;
                $totalHeight = 0;

                for ($i=0; $i < count($prodArr); $i++) {

                    $totalWeight += $prodArr[$i]['weight'];
                    $totalLength += $prodArr[$i]['depth'];
                    $totalWidth += $prodArr[$i]['width'];
                    $totalHeight += $prodArr[$i]['height'];


                    $prodDetail[$i]['product_name'] = $prodArr[$i]['name'];
                    $prodDetail[$i]['id_product'] = $prodArr[$i]['id_product'];
                    $prodDetail[$i]['product_quantity'] = $prodArr[$i]['cart_quantity'];
                    $prodDetail[$i]['width'] = $prodArr[$i]['width'];
                    $prodDetail[$i]['height'] = $prodArr[$i]['height'];
                    $prodDetail[$i]['length'] = $prodArr[$i]['depth'];
                    $prodDetail[$i]['weight'] = $prodArr[$i]['weight'];

                }

                /**
                 * Send the details through the API
                 * Return the price sent by the API
                 */

                $addArr = explode(',', $addressArray['address2']);

                $result =
                    [
                        'type' => 'delivery',
                        'pickup' =>
                            [
                                'address' => Configuration::get('FRANK_ADDRESS_1'),
                                'location' =>
                                    [
                                        (float)Configuration::get('FRANK_LONGITUDE'),
                                        (float)Configuration::get('FRANK_LATITUDE')
                                    ],
                                'shortAddress' => Configuration::get('FRANK_ADDRESS_1'),
                                'city' => Configuration::get('FRANK_STORE_CITY'),
                                'country' => Configuration::get('FRANK_STORE_COUNTRY')
                            ],
                        'dropoff' =>
                            [
                                'address' => pSQL($addressArray['address1']),
                                'location' =>
                                    [
                                        (float) $addArr[1],
                                        (float) $addArr[0]
                                    ],
                                'shortAddress' => pSQL($addressArray['address1']),
                                'city' => pSQL($addressArray['city']),
                                'country' => pSQL($addressArray['country'])
                            ],
                        'commodities' => $prodDetail,

                        'contact' =>
                            [
                                'name' => $addressArray['firstname'] . ' ' . $addressArray['lastname'],
                                'number' => !empty($addressArray['phone']) ? $addressArray['phone'] : '',
                                'email' => $addressArray['email'],
                                'countryCode' => $this->countryCode(pSQL($addressArray['country'])),
                            ],

                        'deliveryType' => $carrierName,
                        'totalWeight' => sprintf("%.2f",$totalWeight),
                        'totalWidth' => sprintf("%.2f",$totalWidth),
                        'totalHeight' => sprintf("%.2f",$totalHeight),
                        'totalLength' => sprintf("%.2f",$totalLength),
                        'priceImpact' => 20,
                        'orderNumber' => 420586190927,
                        'store' => Configuration::get('FRANK_ID')
                    ];

                $res = $this->frank_api->doCurlRequest('https://p-post.herokuapp.com/api/v1/orders/rates', $result, Configuration::get('FRANK_TOKEN'));
                $res = json_decode($res, true);
                return ($res['data']['rates']['price']) + $shipping_cost;
//        return ($res['data']['rates']['price']);
            }
        }
    }

    public function getOrderShippingCostExternal($params)
    {
//        return 23;
        return $this->getOrderShippingCost($params, 0);
    }

    public function hookDisplayOrderConfirmation($params)
    {
        if ($this->activate()) {
            $controller = $this->getHookController('orderConfirmation');
            return $controller->run($params);
        }
    }


    /**
     * Add the CSS & JavaScript files you want to be added on the FO.
     */
    public function hookHeader()
    {
        $this->context->controller->addJS($this->_path.'/views/js/front.js');
        $this->context->controller->addCSS($this->_path.'/views/css/front.css');
    }

    public function hookActionFrontControllerSetMedia($params)
    {
        $this->context->controller->addCSS($this->_path.'/views/css/front.css');

    }

    public function getHookController($hook_name)
    {
        require_once(dirname(__FILE__).'/controllers/hook/'. $hook_name.'.php');
        $controller_name = $this->name.$hook_name.'Controller';
        $controller = new $controller_name($this, __FILE__, $this->_path);
        return $controller;
    }

    public function hookActionCarrierUpdate($params)
    {
        $controller = $this->getHookController('actionCarrierUpdate');
        return $controller->run($params);
    }

    public function hookDisplayCarrierList()
    {
        return "Test";
//        $controller = $this->getHookController('displayCarrierList');
//        return $controller->run();
    }

    public function hookDisplayAdminOrder($params)
    {
        $controller = $this->getHookController('displayAdminOrder');
        return $controller->run();
    }

    public function countryCode($countryName)
    {
        $countries = Country::getCountries($this->context->country);
        foreach ($countries as $country) {
            if ($country['name'] === $countryName) {
                return $country['call_prefix'];
            }
        }
    }

    public function getCarrier($carrierId){
        $result = Db::getInstance()->executeS(
            'SELECT ' .DB_PREFIX .'carrier.`name` 
            FROM ' .DB_PREFIX .'carrier
            WHERE ' .DB_PREFIX .'carrier.`id_carrier` ='. $carrierId);
        return $result;
    }

    public function activate()
    {
        return true;
        $active = $this->frank_api->getRequests('https://p-post.herokuapp.com/api/v1/stores/myprofile/' . Configuration::get('FRANK_ID'), Configuration::get('FRANK_TOKEN'));
        $active = json_decode($active, true);
        if ($active['status'] === 200)
            return $active['data']['active'];
        return 'Something went wrong';
    }
}