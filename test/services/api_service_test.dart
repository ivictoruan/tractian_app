import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:tractian_app/domain/company_model.dart';
import 'package:tractian_app/services/api_service.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late DioApiServiceImpl apiService;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();

    // Criando um stub para options
    final BaseOptions mockOptions = BaseOptions();
    when(mockDio.options).thenReturn(mockOptions);

    apiService = DioApiServiceImpl(dio: mockDio);
  });

  group('DioApiService', () {
    test('fetchCompanies returns list of CompanyModel on success', () async {
      // Arrange+
      final mockResponse = Response(
        data: [
          {"id": '1', "name": "Company A"},
          {"id": '2', "name": "Company B"},
        ],
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );
      when(mockDio.get('/companies')).thenAnswer((_) async => mockResponse);

      // Act
      final List<CompanyModel> result = await apiService.fetchCompanies();

      // Assert
      expect(result, isA<List<CompanyModel>>());
      expect(result.length, 2);
      expect(result[0].id, '1');
      expect(result[0].name, 'Company A');
      expect(result[1].id, '2');
      expect(result[1].name, 'Company B');
    });

    test('fetchCompanies throws exception on non-200 status code', () async {
      // Arrange
      final mockResponse = Response(
        data: 'Error',
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      );
      when(mockDio.get('/companies')).thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(() => apiService.fetchCompanies(), throwsException);
    });

    test('fetchCompanies throws exception on Dio error', () async {
      // Arrange
      when(mockDio.get('/companies')).thenThrow(DioError(
        requestOptions: RequestOptions(path: ''),
        error: 'Network error',
      ));

      // Act & Assert
      expect(() => apiService.fetchCompanies(), throwsException);
    });
  });
}
