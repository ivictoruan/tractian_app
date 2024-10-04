# 🚀 Mobile Software Engineer - Tractian Challenge

## 📌 Summary
1. Context
2. Challenge
3. Tree Structure
4. Implemented Features
5. Technical Data
6. Development
7. Demonstration
8. Future Improvements
9. Conclusion

## 📚 Context
In the modern industry, assets play a crucial role, ranging from manufacturing equipment to energy generation systems. Efficient management of these assets is essential for maintaining productivity and reducing operational costs. A clear visualization of the asset hierarchy, through a tree structure, significantly facilitates this management process.

## 🎯 Challenge
The main objective of this project is to develop a mobile application that presents a tree visualization of corporate assets. This hierarchical structure is composed of three main elements: components, assets, and locations.

## 🌳 Tree Structure
The asset hierarchy is represented as follows:

- Raiz
  - Local A
    - Ativo 1
      - Componente A1
      - Componente A2
    - Ativo 2
      - Componente B1
      - Componente B2
  - Localização B
    - Localização C
      - Ativo 3
        - Componente C1
        - Componente C2
      - Componente D1
  - Componente X

## 🛠️ Implemented Features

### 1. Home Page
- Intuitive interface for navigating between companies
- Quick access to each company's assets
- UI handling for offline situations or loading errors

### 2. Assets Page
- [OK] Tree Visualization: Dynamic and interactive representation of the asset hierarchy
- [OK] UI handling for offline situations or loading errors
- [PENDING] Advanced Filtering System:

## 📊 Technical Data

### Data Structure for Locations

{
  "id": "65674204664c41001e91ecb4",
  "name": "ÁREA DE PRODUÇÃO - MATÉRIA-PRIMA",
  "parentId": null
}

### Estrutura de Dados dos Ativos
{
  "id": "656734821f4664001f296973",
  "name": "Ventilador - Externo",
  "parentId": null,
  "sensorId": "MTC052",
  "sensorType": "energy",
  "status": "operating",
  "gatewayId": "QHI640",
  "locationId": null
}
## 💻 Development

### Technologies Used
- Framework: Flutter
- State Management: ChangeNotifier + SetState
- Dependency Injection: Provider
- API Consumption (DIO): Efficient implementation for real-time data integration
    - Dependency inversion, decoupling the service
- UI/UX: Responsive and intuitive design, prioritizing user experience

### Best Practices Implemented
- Clean architecture to facilitate maintenance and scalability
- Unit and integration tests to ensure robustness
  - API service
  - Connectivity check service
- Performance optimization for fast loading of large datasets
  - Implementation of an Isolate was lacking for better performance with large amounts of data

## 🎥 Demonstration
[![Watch the demonstration video](https://img.youtube.com/vi/vrGu-ejrLLw/hqdefault.jpg)](https://youtu.be/vrGu-ejrLLw)


The video above demonstrates:
1. App opening
2. Navigation between different companies
3. Asset tree visualization

## 🔮 Future Improvements
1. Implementation of local cache to improve offline performance
2. Addition of asset tree editing functionalities
3. Integration with notification systems for real-time alerts
4. Expansion of data analysis and reporting capabilities
5. Development of filters with chips and a search bar
6. Performance optimization for fast loading of large datasets (Isolate)

## 🏁 Conclusion
The application was developed with a clean architecture approach, ensuring an organized and scalable structure that facilitates maintenance and system evolution. The separation of concerns, domain, services, and UI allows for effective inversion of control, ensuring that business logic remains independent of the presentation layer.

---

Desenvolvido com 🫣 por Victor Ruan Diniz Pereira
