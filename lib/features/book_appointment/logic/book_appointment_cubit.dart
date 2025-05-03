import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/book_appointment/logic/book_appointment_state.dart';
import 'package:healthstack/features/book_appointment/data/repos/book_appointment_repo.dart';
import 'package:healthstack/features/book_appointment/data/models/book_appointment_request_model.dart';

class BookAppointmentCubit extends Cubit<BookAppointmentState> {
  final BookAppointmentRepo _bookAppointmentRepo;
  String? selectedDate;
  String? selectedTime;
  String? selectedAppointmentType;
  String? message;
  DoctorsResponseModel? doctorsData;
  
  BookAppointmentCubit(this._bookAppointmentRepo) : super((const BookAppointmentState.initial()));
  
  void updateBookingDetails({
    String? date,
    String? time,
    String? type,
    DoctorsResponseModel? doctor, 
  }) {
    selectedDate = date ?? selectedDate;
    selectedTime = time ?? selectedTime;
    selectedAppointmentType = type ?? selectedAppointmentType;
    doctorsData = doctor ?? doctorsData;
  
  }
  
  void updateMessage(String newMessage) {
    message = newMessage;
  }
  
  Future<void> submitBooking() async {
    if (selectedDate == null || selectedTime == null || selectedAppointmentType == null || doctorsData?.doctorId == null) {
        emit(BookAppointmentState.error(error: "Please select all fields"));
        return;
    }
    print("Selected Time: $selectedTime");
    emit(const BookAppointmentState.loading());
      
    final requestModel = BookAppointmentRequestModel(
        date: selectedDate!,
        time: selectedTime!,
        appointmentType: selectedAppointmentType!,
        message: message ?? "", 
        doctor: doctorsData!.doctorId!, 
    );
      
    final response = await _bookAppointmentRepo.bookAppointment(requestModel);
      
    response.when(
        success: (bookingResponseData) {
            emit(BookAppointmentState.success(bookingResponseData));
        },
        failure: (errorHandler) {
            emit(BookAppointmentState.error(error: errorHandler.apiErrorModel.message ?? 'Unknown Error'));
        },
    );
    
  }
}