<php>
class Constants{
static $DB_SERVER = "localhost";
static $DB_NAME = "pricelist_table";
static $USERNAME = "root";
static $PASSWORD= "";

static $SQL_SELECT_ALL="SELECT * FROM products";

}
class Products{
    public function connect(){
        $con = new mysqli(Constants::$DB_SERVER, Constants::$USERNAME,
         Constants::$PASSWORD, Constants::$DB_NAME);
         if($con->connect_error){
            return null;
         }else{
         return $con;
         }
    }
    public function select(){
     $con=$this->connect();
     if($con != null){
        $result=$con->query(Constants::$SQL_SELECT_ALL);
        if($result->num_rows>0){
            $products=array();
            while($row=$result->fetch_array()){
            array_push($spacecrafts, array("product_id"=>$row['product_id'],
            "product_name"=>$row['product_name'],
            "product_price" =>$row['product_price']));
            }
        }
      print(json_encode(array_reverse($spacecrafts)));
             }else
             {
                 print(json_encode(array("PHP EXCEPTION : CAN'T RETRIEVE FROM MYSQL. ")));
             }
             $con->close();

         }else{
             print(json_encode(array("PHP EXCEPTION : CAN'T CONNECT TO MYSQL. NULL CONNECTION.")));
         }
    }
}
</php>