import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:http/http.dart' as http;
import '../SignIn_Page.dart';
import 'Models/Products_Model.dart';
import 'ProductScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}





class _HomePageState extends State<HomePage> {

  List<ProductsModel> products =[];

  Future<List<ProductsModel>> getProducts() async{
    final response = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200){

      for(Map i in data){
        products.add(ProductsModel.fromJson(i));
      }
      return products;

    }else{
       return products;
    }

  }

  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Get.offAll(SigninPage());
            },
          )
        ],
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(onPressed: (){
              Get.to(ProductScreen());
            }, child: Text("Shop Now") ),
          ),

            Expanded(
              child: FutureBuilder(
                  future: getProducts(),builder: (context , snapshot){
                    if(!snapshot.hasData){
                      return Text("Loading");
                    }else{
                      return ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context , index){
                        return Container(
                          margin: EdgeInsets.all(35),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                                child: Image.network(
                                  products[index].image ?? "",
                                  height: 140,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(products[index].title ?? "",

                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(products[index].description ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 6),

                                    Text(
                                      "₹${products[index].price}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    Row(
                                      children: [
                                        // Star rating
                                        Row(
                                          children: List.generate(
                                            5,
                                                (index) => Icon(
                                              Icons.star,
                                              size: 16,
                                              color: index <
                                                  (products[index].rating?.rate?? 0).round()
                                                  ? Colors.amber
                                                  : Colors.grey.shade300,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "${products[index].rating?.count ?? 0}",
                                          style: TextStyle(color: Colors.grey.shade600),
                                        ),
                                      ],
                                    ),


                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      });
                    }
              }
              
              ),
            ),

          //SizedBox(height: 10,),

         

        ],
      )
    );
  }
}
