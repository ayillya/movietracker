import 'package:flutter/material.dart';


class RetryButton extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;
  const RetryButton({
    super.key,required this.error,required this.onRetry,
  });
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(error,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.deepOrange),textAlign:TextAlign.center)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text("Retry",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
          ),
        ],
      ),
    );
  }
}
