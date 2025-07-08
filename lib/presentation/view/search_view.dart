import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/core/model/weather_model.dart';
import 'package:task/core/utils/responsive.dart';
import 'package:task/core/widgets/custom_button.dart';
import 'package:task/core/widgets/custom_text_form_field.dart';
import 'package:task/presentation/cubit/weather_cubit.dart';
import 'package:task/presentation/cubit/weather_state.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    print("$height  ////  $width");
    final responsive = Responsive.of(context);
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Weather', style: GoogleFonts.anekDevanagari()),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: responsive.widthPercent(7.7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter city name",
              style: GoogleFonts.anekDevanagari(
                fontSize: responsive.widthPercent(4.9),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: responsive.heightPercent(1.5)),
            CustomTextFormField(
              hint: 'Enter city name',
              textInputType: TextInputType.text,
              controller: controller,
            ),
            SizedBox(height: responsive.heightPercent(4)),
            CustomButon(
              text: 'Search',
              color: Colors.blue,
              onTap: () {
                final city = controller.text.trim();
                if (city.isNotEmpty) {
                  context.read<WeatherCubit>().fetchWeather(city);
                }
              },
            ),
            SizedBox(height: responsive.heightPercent(4)),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is WeatherLoaded) {
                  return weatherCard(state.weather, responsive);
                } else if (state is WeatherError) {
                  return Center(child: Text(state.message));
                }
                return Center(child: Text('Enter a city name'));
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget weatherCard(WeatherModel weather, Responsive responsive) {
  return Container(
    width: double.infinity,
    child: Card(
      elevation: 5,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              weather.cityName,
              style: GoogleFonts.anekDevanagari(
                fontSize: responsive.widthPercent(5.8),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: responsive.heightPercent(.8)),
            Image.network(
              weather.iconUrl,
              width: responsive.widthPercent(15.5),
              height: responsive.heightPercent(7),
            ),
            SizedBox(height: responsive.heightPercent(.8)),
            Text(
              '${weather.temperature}',
              style: GoogleFonts.anekDevanagari(
                fontSize: responsive.widthPercent(7.8),
              ),
            ),
            SizedBox(height: responsive.heightPercent(.8)),
            Text(
              weather.description,
              style: GoogleFonts.anekDevanagari(
                fontSize: responsive.widthPercent(4.8),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
