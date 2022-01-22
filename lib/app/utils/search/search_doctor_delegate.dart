import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hallo_doctor_client/app/models/doctor_model.dart';
import 'package:hallo_doctor_client/app/service/doctor_service.dart';

class SearchDoctorDelegat extends SearchDelegate<Doctor> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, Doctor());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) => FutureBuilder<List<Doctor>>(
      future: DoctorService().searchDoctor(query),
      builder: (contex, snapshot) {
        if (query.isEmpty) return buildNoSuggestions();
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: Text(
                  'Something went wrong!',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
              );
            } else {
              return buildResultSuccess(snapshot.data!);
            }
        }
      });

  @override
  Widget buildSuggestions(BuildContext context) => FutureBuilder<List<Doctor>>(
        future: DoctorService().searchDoctor(query),
        builder: (context, snapshot) {
          if (query.isEmpty) return buildNoSuggestions();
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError || snapshot.data!.isEmpty) {
                return buildNoSuggestions();
              } else {
                return buildSuggestionsSuccess(snapshot.data!);
              }
          }
        },
      );

  Widget buildSuggestionsSuccess(List<Doctor> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion.doctorName!.substring(0, query.length);
          final remainingText = suggestion.doctorName!.substring(query.length);

          return ListTile(
            onTap: () {
              query = suggestion.doctorName!;
              showResults(context);
            },
            leading: Icon(Icons.person),
            // title: Text(suggestion),
            title: RichText(
              text: TextSpan(
                text: queryText,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: remainingText,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
  Widget buildNoSuggestions() => Center(
        child: Text(
          'No suggestions!',
          style: TextStyle(fontSize: 28, color: Colors.black45),
        ),
      );

  Widget buildResultSuccess(List<Doctor> doctor) => ListView.builder(
      itemCount: doctor.length,
      itemBuilder: (contex, index) {
        return ListTile(
          onTap: () {
            close(contex, doctor[index]);
          },
          leading: CircleAvatar(
            backgroundImage:
                CachedNetworkImageProvider(doctor[index].doctorPicture!),
          ),
          title: Text(doctor[index].doctorName!),
        );
      });
}
